<template>
    <div>
        <div class="card mb-4">
            <div class="card-body">
                <div class="py-5">
                    <h5 class="text-center">주문번호 <span class="h4 font-weight-bold">{{ order.orderCode }}</span>상세내역입니다.</h5>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <button class="btn btn-sm btn-outline-danger" id="order_delete" @click="deleteOrder">
                            <i class="fa fa-trash"></i> 주문삭제
                        </button>
                        <button v-if="order.orderStatus === 'completed'" class="btn btn-sm btn-warning"
                                @click="cancelOrder">주문취소
                        </button>
                    </div>
                    <div class="col-md-6 text-right">
                        <button class="btn btn-sm btn-outline-secondary" @click="printOrder" type="button">
                            <i class="fa fa-scroll"></i>
                            거래명세표
                        </button>
                        <button v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'"
                                class="btn btn-sm btn-outline-danger" @click="changeReleaseStatus('rejected')">
                            <i class="fa fa-times"></i>출고거절
                        </button>
                        <button v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'"
                                class="btn btn-sm btn-outline-primary" @click="changeReleaseStatus('completed')">
                            <i class="fa fa-check"></i>출고완료
                        </button>
                        <button v-if="order.orderStatus === 'completed' && order.releaseStatus === 'completed'"
                                class="btn btn-sm btn-outline-warning" type="button" data-toggle="modal"
                                data-target="#returnOrderModal">
                            반품접수
                        </button>
                    </div>
                </div>
                <hr>
                <h5 class="card-title">주문 정보
                    <span class="text-primary">
                                        (주문상태:
                        <template v-if="order.orderStatus === 'completed'">
                            주문완료
                        </template>
                        <template v-else-if="order.orderStatus === 'canceled'">
                            주문취소
                        </template>
                    </span>
                    <span class="mx-1">/</span>
                    <span class="text-success">
                        출고상태:
                        <template v-if="order.releaseStatus === 'progress'">
                            출고전
                        </template>
                        <template v-else-if="order.releaseStatus === 'rejected'">
                            출고거절
                        </template>
                        <template v-else-if="order.releaseStatus === 'completed'">
                            출고완료
                        </template>
                        )
                    </span>
                </h5>
                <table class="table form-table table-bordered mb-4">
                    <colgroup>
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="35%">
                    </colgroup>
                    <tbody class="thead-light">
                    <tr>
                        <th>주문번호</th>
                        <td>{{ order.orderCode }}</td>
                        <th>거래처</th>
                        <td>{{ order.shop.name }}</td>
                    </tr>
                    <tr>
                        <th>주문일자</th>
                        <td>{{ order.createdAt }}</td>
                        <th>담당자/연락처</th>
                        <td>{{ order.shop.shopOwner.fullName }} / {{order.shop.shopOwner.phone }}</td>
                    </tr>
                    <tr>
                        <th>거래처 주소</th>
                        <td colspan="3">{{ order.shop.addressLine1 }} {{ order.shop.addressLine2 }}</td>
                    </tr>
                    <tr>
                        <th>결제수단</th>
                        <td>
                            <template v-if="order.shop.paymentMethod === 'credit'">외상결제</template>
                            <template v-else-if="order.shop.paymentMethod === 'prepaid'">예치금</template>
                        </td>
                        <th>총 주문금액</th>
                        <td>{{ order.totalAmount }}</td>
                    </tr>
                    <tr>
                        <th>주문 이력</th>
                        <td colspan="3">
                            <button type="button" class="btn btn-sm btn-outline-dark">주문이력 보기</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h5 class="card-title">배송 정보</h5>
                <table class="table form-table table-bordered mb-4">
                    <colgroup>
                        <col width="15%">
                        <col width="35%">
                        <col width="15%">
                        <col width="35%">
                    </colgroup>
                    <tbody class="thead-light">
                    <tr>
                        <th>배송유형</th>
                        <td>
                            <template v-if="order.deliveryType === 'parcel'">택배배송</template>
                            <template v-else-if="order.deliveryType === 'direct'">직배송</template>
                        </td>
                        <th>배송요청일</th>
                        <td>
                            <div class="input-group input-group-sm">
                                <input type="text" class="form-control" v-model="requestDate"
                                       id="requestDate"/>
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <button type="button" class="btn btn-outline-primary" @click="changeRequestDate">변경</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="required"><span>배송 담당자</span></th>
                        <td>
                            <div class="input-group input-group-sm">
                                <select v-model="selected_deliverer_id" class="form-control">
                                    <option v-bind:value="null">-- 선택 --</option>
                                    <option v-for="deliverer in deliverers" v-bind:value="deliverer.id">
                                        {{ deliverer.fullName }}
                                    </option>
                                </select>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-primary" @click="changeDeliverer">변경</button>
                                </div>
                            </div>
                        </td>
                        <th>영업 담당자</th>
                        <td>
                            <div class="input-group input-group-sm">
                                <select class="form-control form-control-sm" v-model="selected_salesman_id">
                                    <option v-bind:value="null">-- 선택 --</option>
                                    <option v-for="salesman in salesMans" v-bind:value="salesman.id">
                                        {{ salesman.fullName }}
                                    </option>
                                </select>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-primary" @click="changeSalesman">변경</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>요청사항</th>
                        <td colspan="3">
                            {{ order.requestMemo }}
                        </td>
                    </tr>
                    <tr>
                        <th>메모</th>
                        <td colspan="3">
                            <div class="input-group input-group-sm">
                                <textarea class="form-control" rows="3" v-model="memo"/>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-primary" @click="changeMemo">변경</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h5 class="card-title">상품 목록</h5>
                <div class="row mb-2">
                    <div class="col-6">
                        <span></span>
                    </div>
                    <div class="col-6 text-right">
                        <button class="btn btn-sm btn-outline-primary float-right" v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'" @click="showProductsModal">상품추가
                        </button>
                    </div>
                </div>
                <table id="cartTable" class="table table-sm text-center table-middle table-hover mb-5">
                    <colgroup>
                        <col style="width: 5%">
                        <col>
                        <col>
                        <col>
                        <col style="width: 10%">
                        <col style="width: 10%">
                        <col style="width: 8%">
                    </colgroup>
                    <thead class="thead-light">
                    <tr>
                        <th>#</th>
                        <th>상품명</th>
                        <th>규격<br>(단위)</th>
                        <th>제조사<br>(원산지)</th>
                        <th>수량</th>
                        <th>단가(원)</th>
                        <th>합계금액(원)</th>
                        <th v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'">삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(orderProduct, index) in order_products">
                        <td>{{ index + 1 }}</td>
                        <td>{{ orderProduct.product.name }}</td>
                        <td>{{ orderProduct.product.standard }}<br>({{ orderProduct.product.unit }})</td>
                        <td>{{ orderProduct.product.makerName }}<br>({{ orderProduct.product.country }})</td>
                        <td>
                            <template v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'">
                                <input class="form-control form-control-sm text-center" type="number" v-model.number="orderProduct.qty">
                            </template>
                            <template v-else>
                                {{ orderProduct.qty }}
                            </template>
                        </td>
                        <td>
                            <template v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'">
                                <input class="form-control form-control-sm text-right" type="number"
                                       v-model.number="orderProduct.price">
                            </template>
                            <template v-else>
                                {{ orderProduct.price }}
                            </template>
                        </td>
                        <td>{{ orderProduct.qty * orderProduct.price }}</td>
                        <td v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'">
                            <button class="btn btn-outline-danger btn-sm" @click="removeOrderProduct(orderProduct)">삭제</button>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot class="thead-light">
                    <tr>
                        <th>합계</th>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-center">{{ total_qty }}</td>
                        <td></td>
                        <td>{{ total_amount }}</td>
                        <td v-if="order.orderStatus === 'completed' && order.releaseStatus === 'progress'"></td>
                    </tr>
                    </tfoot>
                </table>
                <div class="form-group text-center">
                    <a href="/orders" class="btn btn-dark">목록으로</a>
                    <button class="btn btn-outline-primary" @click="submitForm">주문 변경 완료</button>
                </div>
            </div>
        </div>
        <div class="modal fade" id="selectProducts">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <div class="modal-title text-light">
                            {{ products_modal_title }}
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
                                            <col width="10%">
                                            <col width="15%">
                                            <col width="15%">
                                        </colgroup>
                                        <thead class="thead-light">
                                        <tr>
                                            <th>상품명</th>
                                            <th>재고량</th>
                                            <th>매입 단가(원)</th>
                                            <th>판매 단가(원)</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="product in products" @click="selectedProduct(product)">
                                            <td>{{ product.name }}</td>
                                            <td>{{ product.qty }}</td>
                                            <td>{{ product.buyPrice }}</td>
                                            <td>{{ product.sellPrice }}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div class="row mb-3">
                                    <div class="col-6">선택상품 목록<span>(전체 {{ order_products.length }}건)</span></div>
                                    <div class="col-6 text-right">
                                        <button class="btn btn-sm btn-outline-primary" @click="resetOrderProducts"><i
                                                class="fa fa-undo"></i></button>
                                    </div>
                                </div>
                                <div id="goods_select_wrap">
                                    <div style="height:420px; overflow: auto;">
                                        <ul class="list-group" id="shopping_cart">
                                            <li class="list-group-item" v-for="order_product in order_products">
                                                <button class="close" @click="removeOrderProduct(order_product)">
                                                    &times;
                                                </button>
                                                <h6>{{ order_product.product.name }}</h6>
                                                <p><span class="unit">{{ order_product.product.unit }}</span> / <span
                                                        class="country">{{ order_product.product.country }}</span></p>
                                                <div class="form-inline">
                                                    <select class="form-control form-control-sm" style="width: 37%;">
                                                        <option v-bind:value="null">--단가 그룹 선택 --</option>
                                                        <option v-for="priceGroup in priceGroups"
                                                                v-bind:value="priceGroup.id">{{ priceGroup.name }}
                                                        </option>
                                                    </select>
                                                    <input class="form-control form-control-sm text-center mx-2"
                                                           style="width: 20%;" type="number"
                                                           v-model.number="order_product.qty">
                                                    <div class="input-group input-group-sm" style="width: 35%">
                                                        <input class="form-control form-control-sm text-right"
                                                               type="number" v-model.number="order_product.price">
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
                                            <div class="col-6 text-right">{{ total_amount }}원</div>
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
    export default {
        data() {
            return {
                order: {
                    shop: {
                        shopOwner: {},
                        deliverer: {},
                        salesMan: {}
                    }
                },
                requestDate: '',
                salesMans: [],
                deliverers: [],
                selected_deliverer_id: null,
                selected_salesman_id: null,
                memo: '',
                products_modal_title: '',
                categories: [],
                selected_category_id: null,
                subcategories: [],
                selected_subcategory_id: null,
                product_keyword: '',
                products: [],
                order_products: [],
                total_amount: 0,
                total_qty: 0,
                priceGroups: [],
                showCartTable: false
            }
        },
        mounted() {
            let self = this;

            $('#requestDate').datepicker({
                dateFormat: 'yy-mm-dd',
                onSelect: function (selectedDate, datePicker) {
                    self.requestDate = selectedDate;
                }
            });

            let currentUrl = window.location.pathname;

            axios.get(`${currentUrl}/ajax`)
                .then(res => res.data)
                .then(data => {
                    this.order = data.order;
                    this.selected_deliverer_id = data.order.deliverer.id;
                    if (data.order.salesMan) {
                        this.selected_salesman_id = data.order.salesMan.id;
                    }
                    this.requestDate = data.order.requestDate;
                    console.log(this.requestDate);
                    this.order_products = data.order.orderProducts;
                })
                .catch(err => {
                    console.log(err);
                })

            axios.get('/users/deliverers_salesmans')
                .then(response => response.data)
                .then(data => {
                    this.deliverers = data.deliverers;
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
            axios.get('/price-groups/data')
                .then(res => res.data)
                .then(data => {
                    this.priceGroups = data.priceGroups;
                })
                .catch(err => {
                    console.log(err);
                })
        },
        methods: {
            showProductsModal: function () {
                this.products_modal_title = (this.deliveryType === 'direct' ? '직배송' : '택배 배송') + ' 상품 검색 및 선택';
                this.searchProducts();
                $('#selectProducts').modal('show');
            },
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
                axios.get('/products/data_for_order', {
                    params: {
                        category: this.selected_category_id,
                        subcategory: this.selected_subcategory_id,
                        keyword: this.product_keyword,
                        deliveryType: (this.order.deliveryType === 'direct' ? 1 : 2)
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
                let orderProductId = this.order_products.findIndex(x => x.product.id === product.id);
                let orderProduct = {};
                if (orderProductId !== -1) {
                    orderProduct = this.order_products[orderProductId];
                    orderProduct.qty = orderProduct.qty + 1;
                } else {
                    orderProduct.product = Object.assign({}, product);
                    orderProduct.price = product.sellPrice;
                    orderProduct.qty = 1;
                    this.order_products.push(orderProduct);
                }
            },
            resetOrderProducts: function () {
                this.order_products = [];
            },
            removeOrderProduct: function (order_product) {
                this.order_products.splice(this.order_products.indexOf(order_product), 1);
            },
            saveOrderProducts: function () {
                this.showCartTable = true;
                $('#selectProducts').modal('hide');
            },
            submitForm: function () {
                if (!this.selected_deliverer_id || this.order_products.length === 0) {
                    toastr.error('필수 입력 사항들을 입력하세요.');
                    return false;
                }

                this.updateOrder('orderProducts', this.order_products);
            },
            printOrder: function () {
                window.open('/orders/print_order?ids='+this.order.id, "거래명세표", "width=1301, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
            },
            changeReleaseStatus: function (status) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post(`/orders/change_status`, {
                    id: this.order.id,
                    action: 'release',
                    status: status
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        window.location.href = '/orders';
                    })
                    .catch(err => {
                        console.log(err);
                    })
            },
            cancelOrder: function () {
                window.location.href = '/orders/' + this.order.id + '/cancel';
            },
            deleteOrder: function () {
                window.location.href = '/orders/' + this.order.id + '/delete';
            },
            changeRequestDate: function () {
                this.updateOrder("requestDate", this.requestDate);
            },
            changeDeliverer: function () {
                if (this.selected_deliverer_id) {
                    this.updateOrder("deliverer", this.selected_deliverer_id);
                }
            },
            changeSalesman: function () {
                this.updateOrder("salesMan", this.selected_salesman_id);
            },
            changeMemo: function () {
                this.updateOrder('memo', this.memo);
            },
            updateOrder: function (field, value) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post(`/orders/${this.order.id}/update`, {
                    field: field,
                    value: value
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        toastr.success(data.message);
                        window.location.href = '/orders';
                    })
                    .catch(err => {
                        console.log(err);
                    })
            }
        },
        watch: {
            order_products: {
                deep: true,
                handler(items) {
                    let total_funds = 0;
                    let total_qty = 0;
                    items.forEach(item => {
                        total_funds += item.price * item.qty;
                        total_qty += item.qty;
                    });
                    this.total_qty = total_qty;
                    this.total_amount = total_funds;
                }
            },
            deliveryType: function (val) {
                this.order_products = [];
            }
        }
    }
</script>
