<template>
    <div>
        <div class="card mb-4">
            <div class="card-body">
                <div class="row">
                    <div class="col-6">
                        <button class="btn btn-sm btn-danger" @click="deleteOrder"><i class="fa fa-trash"></i> 발주삭제</button>
                    </div>
                    <div class="col-6 text-right">
                        <button class="btn btn-sm btn-outline-secondary" @click="printOrder"><i class="fa fa-print"></i> 발주서 출력</button>
                        <template v-if="shippingStatus === 'standby'">
                            <button class="btn btn-sm btn-outline-primary" @click="completeShipping">발주완료</button>
                        </template>
                        <template v-if="shippingStatus === 'completed' && inputStatus === 'standby'">
                            <button class="btn btn-sm btn-outline-primary" @click="completeInput">입고완료</button>
                        </template>
                    </div>
                </div>
                <hr>
                <h5 class="card-title">
                    발주 정보
                    <span class="badge badge-info">발주상태: {{ shippingStatus }}</span>
                    <span class="badge badge-success">입고상태: {{ inputStatus }}</span>
                </h5>
                <table class="table form-table table-bordered mb-4">
                    <tbody class="thead-light">
                    <tr>
                        <th>매입처</th>
                        <td>
                            {{ selectedSupplier.name }}
                        </td>
                    </tr>
                    <tr>
                        <th>납기일자</th>
                        <td>
                            <div class="input-group input-group-sm w-40">
                                <input type="text" class="form-control" v-model="deliverBy"
                                       id="requestDate"/>
                                <div class="input-group-append">
                                <span class="input-group-text">
                                    <i class="fa fa-calendar"></i>
                                </span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="required"><span>담당자</span></th>
                        <td>
                            <select v-model="salesManId" class="form-control form-control-sm w-40">
                                <option v-bind:value="null">-- 선택 --</option>
                                <option v-for="salesman in salesMans" v-bind:value="salesman.id">
                                    {{ salesman.fullName }}
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td>
                            <textarea class="form-control w-50" rows="3" v-model="description" />
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h5 class="card-title">상품 목록</h5>
                <div class="row mb-2">
                    <div class="col-6">
                        <span></span>
                    </div>
                    <div class="col-6 text-right" v-if="inputStatus === 'standby'">
                        <button class="btn btn-sm btn-outline-primary float-right" @click="showProductsModal">상품추가
                        </button>
                    </div>
                </div>
                <table id="cartTable" class="table table-sm text-center table-middle table-hover mb-5">
                    <colgroup>
                        <col style="width: 5%">
                        <col>
                        <col>
                        <col>
                        <col style="width: 8%">
                        <col style="width: 12%">
                        <col style="width: 12%">
                        <col v-if="inputStatus === 'standby'" style="width: 8%">
                    </colgroup>
                    <thead class="thead-light">
                    <tr>
                        <th>#</th>
                        <th>상품명</th>
                        <th>규격<br>(단위)</th>
                        <th>제조사<br>(원산지)</th>
                        <th>수량</th>
                        <th>매입 단가(원)</th>
                        <th>합계금액(원)</th>
                        <th v-if="inputStatus === 'standby'">삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(orderProduct, index) in orderProducts">
                        <td>{{ index + 1 }}</td>
                        <td>{{ orderProduct.product.name }}</td>
                        <td>{{ orderProduct.product.standard }}<br>({{ orderProduct.product.unit }})</td>
                        <td>{{ orderProduct.product.makerName }}<br>({{ orderProduct.product.country }})</td>
                        <td>
                            <template v-if="inputStatus === 'completed'">
                                {{ orderProduct.qty }}
                            </template>
                            <template v-else>
                                <input class="form-control form-control-sm text-center" type="number" v-model.number="orderProduct.qty">
                            </template>
                        </td>
                        <td>
                            <template v-if="inputStatus === 'completed'">
                                {{ Number(orderProduct.price).toLocaleString() }}
                            </template>
                            <template v-else>
                                <NumberInput class="form-control form-control-sm text-right" v-model.number="orderProduct.price" />
                            </template>
                        </td>
                        <td>{{ Number(orderProduct.qty * orderProduct.price).toLocaleString() }}</td>
                        <td v-if="inputStatus === 'standby'">
                            <button class="btn btn-outline-danger btn-sm" @click="removeOrderProduct(index)">삭제</button>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot class="thead-light">
                    <tr>
                        <th>합계</th>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>{{ totalQty }}</td>
                        <td></td>
                        <td>{{ Number(totalFunds).toLocaleString() }}</td>
                        <td v-if="inputStatus === 'standby'"></td>
                    </tr>
                    </tfoot>
                </table>
                <div class="form-group text-center">
                    <a href="/shipping" class="btn btn-dark">목록으로</a>
                    <button class="btn btn-outline-primary" @click="submitForm">수정하기</button>
                </div>
            </div>
        </div>
        <div class="modal fade" id="selectProducts" v-if="inputStatus === 'standby'">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <div class="modal-title text-light">
                            발주 상품 검색
                        </div>
                        <button type="button" class="close text-right" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table form-table table-bordered">
                            <tbody class="thead-light">
                            <tr>
                                <th>키워드 검색</th>
                                <td>
                                    <input class="form-control form-control-sm" v-model="product_keyword"
                                           @keyup="searchProducts" placeholder="상품명 또는 상품코드를 입력하세요."/>
                                </td>
                                <td>
                                    <button class="btn btn-outline-primary" @click="searchProducts">검색</button>
                                </td>
                            </tr>
                            <tr>
                                <th>즉시 검색</th>
                                <td colspan="2">
                                    <div class="form-inline">
                                        <select class="form-control form-control-sm w-25 mr-2"
                                                v-model="selected_category_id"
                                                @change="changedCategory(selected_category_id)">
                                            <option v-bind:value="null">1차 카테고리</option>
                                            <option v-for="category in categories" v-bind:value="category.id">
                                                {{ category.name }}
                                            </option>
                                        </select>
                                        <select class="form-control form-control-sm w-25"
                                                v-model="selected_subcategory_id" @change="searchProducts">
                                            <option v-bind:value="null">2차 카테고리</option>
                                            <option v-for="subcategory in subcategories" v-bind:value="subcategory.id">
                                                {{ subcategory.name }}
                                            </option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-lg-7">
                                <div class="row mb-3">
                                    <div class="col-6 text-primary">
                                        <small>*해당 거래처에서 자주 주문한 상품 순입니다.</small>
                                    </div>
                                    <div class="col-6 text-right">전체 {{ products.length }}건</div>
                                </div>
                                <div class="list-wrap" style="height:460px; overflow: auto;">
                                    <table id="productsTable" class="table table-hover text-center">
                                        <colgroup>
                                            <col width="*">
                                            <col width="30%">
                                        </colgroup>
                                        <thead class="thead-light">
                                        <tr>
                                            <th>상품명</th>
                                            <th>매입 단가(원)</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="product in products" @click="selectedProduct(product)">
                                            <td>{{ product.name }}</td>
                                            <td>{{ Number(product.buyPrice).toLocaleString() }}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="row mb-3">
                                    <div class="col-6">선택상품 목록<span>(전체 {{ orderProducts.length }}건)</span></div>
                                    <div class="col-6 text-right">
                                        <button class="btn btn-sm btn-outline-primary" @click="resetOrderProducts"><i class="fa fa-undo"></i></button>
                                    </div>
                                </div>
                                <div id="goods_select_wrap">
                                    <div style="height:420px; overflow: auto;">
                                        <ul class="list-group" id="shopping_cart">
                                            <li class="list-group-item" v-for="(orderProduct, index) in orderProducts">
                                                <button class="close" @click="removeOrderProduct(index)">&times;</button>
                                                <h6>{{ orderProduct.product.name }}</h6>
                                                <div class="form-inline">
                                                    <input class="form-control form-control-sm text-center mx-2" style="width: 20%;" type="number" v-model.number="orderProduct.qty">
                                                    <div class="input-group input-group-sm" style="width: 35%">
                                                        <NumberInput class="form-control form-control-sm text-right" v-model.number="orderProduct.price" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">원</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="bg-light p-4">
                                        <div class="row">
                                            <div class="col-6">합계금액</div>
                                            <div class="col-6 text-right">{{ Number(totalFunds).toLocaleString() }}원</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        <button class="btn btn-primary" @click="saveOrderProducts">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import NumberInput from "./NumberInput";

    export default {
        name: "ShippingEdit",
        components: {NumberInput},
        data() {
            return {
                orderId: null,
                selectedSupplier: {},
                deliverBy: '',
                salesMans: [],
                salesManId: null,
                description: '',
                categories: [],
                selected_category_id: null,
                subcategories: [],
                selected_subcategory_id: null,
                product_keyword: '',
                products: [],
                orderProducts: [],
                totalFunds: 0,
                totalQty: 0,
                shippingStatus: null,
                inputStatus: null,
            }
        },
        mounted() {
            let self = this;
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            this.deliverBy = this.formatDate(tomorrow);

            $('#requestDate').datepicker({
                dateFormat: 'yy-mm-dd',
                onSelect: function (selectedDate, datePicker) {
                    self.deliverBy = selectedDate;
                }
            });

            axios.get('/users/deliverers_salesmans')
                .then(response => response.data)
                .then(data => {
                    this.salesMans = data.salesMans;
                })
                .catch(error => {
                    console.log(error);
                });
            axios.get('/categories/all')
                .then(res => res.data)
                .then(data => {
                    this.categories = data.categories;
                })
                .catch(err => {
                    console.log(err);
                });
            let currentUrl = window.location.pathname;

            axios.get(`${currentUrl}/data`)
                .then(res => res.data)
                .then(data => {
                    this.orderId = data.supplyOrder.id;
                    this.selectedSupplier = data.supplyOrder.supplier;
                    this.deliverBy = data.supplyOrder.deliverBy;
                    this.salesManId = data.supplyOrder.user.id;
                    this.description = data.supplyOrder.description;
                    this.orderProducts = data.supplyOrder.supplyOrderProducts;
                    this.shippingStatus = data.supplyOrder.shippingStatus;
                    this.inputStatus = data.supplyOrder.inputStatus;
                    this.orderProducts.forEach(orderProduct => {
                        orderProduct.productId = orderProduct.product.id;
                    });
                })
                .catch(error => {
                    console.log(error);
                })
        },
        methods: {
            formatDate: function (date) {
                let month = '' + (date.getMonth() + 1),
                    day = '' + date.getDate(),
                    year = date.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            },
            showSuppliersModal: function () {
                this.searchSuppliers();
                $('#selectSuppliers').modal('show');
            },
            showProductsModal: function () {
                if (Object.keys(this.selectedSupplier).length === 0) {
                    toastr.error('매입처 선택을 먼저 해주셔야 상품 선택이 가능합니다.');
                } else {
                    this.searchProducts();
                    $('#selectProducts').modal('show');
                }
            },
            selectSupplier: function (idx) {
                this.selectedSupplier = this.suppliers[idx];
                $('#selectSuppliers').modal('hide');
            },
            changedCategory: function (category_id) {
                if (category_id === null) {
                    this.subcategories = [];
                    this.selected_subcategory_id = null;
                } else {
                    let selected_category = this.categories.find(category => category.id === category_id);
                    this.subcategories = selected_category.children;
                    this.selected_subcategory_id = null;
                }
                this.searchProducts();
            },
            searchProducts: function () {
                axios.get('/products/data_for_supply_order', {
                    params: {
                        categoryId: this.selected_category_id,
                        subcategoryId: this.selected_subcategory_id,
                        keyword: this.product_keyword,
                        supplierId: this.selectedSupplier.id,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        this.products = data.products;
                    })
                    .catch(err => {
                        console.log(err);
                    })
            },
            selectedProduct: function (product) {
                let opId = this.orderProducts.findIndex(x => x.product.id === product.id);
                let orderProduct = {};
                if (opId !== -1) {
                    orderProduct = this.orderProducts[opId];
                    orderProduct.qty = orderProduct.qty + 1;
                } else {
                    orderProduct.product = Object.assign({}, product);
                    orderProduct.productId = orderProduct.product.id;
                    orderProduct.price = product.buyPrice;
                    orderProduct.qty = 1;
                    this.orderProducts.push(orderProduct);
                }
            },
            resetOrderProducts: function () {
                this.orderProducts = [];
            },
            removeOrderProduct: function (index) {
                this.orderProducts.splice(index, 1);
            },
            saveOrderProducts: function () {
                $('#selectProducts').modal('hide');
            },
            submitForm: function () {
                let token = $("meta[name='_csrf']").attr("content");

                if (!this.selectedSupplier || !this.salesManId || this.orderProducts.length === 0) {
                    toastr.error('필수 입력 사항들을 입력하세요.');
                    return false;
                }

                axios.post('/shipping/update', {
                    id: this.orderId,
                    deliverBy: this.deliverBy,
                    salesmanId: this.salesManId,
                    description: this.description,
                    orderProducts: this.orderProducts
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        window.location.href = '/shipping';
                    })
                    .catch(err => {
                        console.log(err);
                    })
            },
            deleteOrder: function () {
                let currentUrl = window.location.pathname;
                window.location.href = `${currentUrl}/delete`;
            },
            completeShipping: function () {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/shipping/order_complete', {
                    id: this.orderId,
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        window.location.reload();
                    })
                    .catch(error => {
                        console.log(error);
                    })
            },
            completeInput: function () {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/shipping/input_complete', {
                    id: this.orderId,
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        window.location.reload();
                    })
                    .catch(error => {
                        console.log(error);
                    })
            },
            printOrder: function () {

            }
        },
        watch: {
            orderProducts: {
                deep: true,
                handler(items) {
                    let total_funds = 0;
                    let total_qty = 0;
                    items.forEach(item => {
                        total_funds += item.price * item.qty;
                        total_qty += item.qty;
                    });
                    this.totalQty = total_qty;
                    this.totalFunds = total_funds;
                }
            },
            deliveryType: function (val) {
                this.orderProducts = [];
            }
        }
    }
</script>