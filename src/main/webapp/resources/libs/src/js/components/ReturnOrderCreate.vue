<template>
    <div>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">주문 정보</h5>
                <table class="table form-table table-bordered mb-4">
                    <tbody class="thead-light">
                    <tr>
                        <th class="required"><span>거래처 선택</span></th>
                        <td colspan="3">
                            <div class="input-group input-group-sm w-25">
                                <input type="text" class="form-control" v-model="selected_shop_name">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary" @click="showShopModal">거래처 선택</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>배송유형</th>
                        <td colspan="3">
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" value="direct" id="deliveryType1" v-model="deliveryType"
                                       class="custom-control-input">
                                <label class="custom-control-label" for="deliveryType1">직배송</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" value="parcel" id="deliveryType2" v-model="deliveryType"
                                       class="custom-control-input">
                                <label class="custom-control-label" for="deliveryType2">택배 배송</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="required"><span>배송 담당자</span></th>
                        <td>
                            <select v-model="selected_deliverer_id" class="form-control form-control-sm w-75">
                                <option v-bind:value="null">-- 선택 --</option>
                                <option v-for="deliverer in deliverers" v-bind:value="deliverer.id">
                                    {{ deliverer.fullName }}
                                </option>
                            </select>
                        </td>
                        <th>영업 담당자</th>
                        <td>
                            <select class="form-control form-control-sm w-75" v-model="selected_salesman_id">
                                <option v-bind:value="null">-- 선택 --</option>
                                <option v-for="salesman in salesMans" v-bind:value="salesman.id">
                                    {{ salesman.fullName }}
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>사유</th>
                        <td colspan="3">
                            <textarea class="form-control w-50" rows="3" v-model="memo"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h5 class="card-title">반품 상품 목록</h5>
                <div class="row mb-2">
                    <div class="col-6">
                        <span></span>
                    </div>
                    <div class="col-6 text-right">
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
                        <th>삭제</th>
                    </tr>
                    </thead>
                    <tbody v-if="showCartTable">
                    <tr v-for="(orderProduct, index) in orderProducts">
                        <td>{{ index + 1 }}</td>
                        <td>{{ orderProduct.product.name }}</td>
                        <td>{{ orderProduct.product.standard }}<br>({{ orderProduct.product.unit }})</td>
                        <td>{{ orderProduct.product.makerName }}<br>({{ orderProduct.product.country }})</td>
                        <td><input class="form-control form-control-sm text-center" type="number" v-model.number="orderProduct.qty"></td>
                        <td><NumberInput class="form-control form-control-sm text-right" v-model.number="orderProduct.price" /></td>
                        <td>{{ Number(orderProduct.qty * orderProduct.price).toLocaleString() }}</td>
                        <td>
                            <button class="btn btn-outline-danger btn-sm" @click="removeOrderProduct(index)">삭제</button>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot class="thead-light" v-if="showCartTable">
                    <tr>
                        <th>합계</th>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>{{ total_qty }}</td>
                        <td></td>
                        <td>{{ Number(total_amount).toLocaleString() }}</td>
                        <td></td>
                    </tr>
                    </tfoot>
                </table>
                <div class="form-group text-center">
                    <a href="/orders" class="btn btn-dark">목록으로</a>
                    <button class="btn btn-outline-primary" @click="submitForm">등록하기</button>
                </div>
            </div>
        </div>
        <div class="modal fade" id="selectShops">
            <div class="modal-dialog-centered modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <div class="modal-title text-light">거래처 검색</div>
                        <button class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <label class="col-form-label text-right col-3 font-weight-bold">검색</label>
                            <div class="col-8">
                                <div class="input-group input-group-sm">
                                    <input type="text" v-model="shop_keyword" @keyup="searchShops" title="검색어 입력"
                                           class="form-control form-control-sm" placeholder="검색어를 입력해주세요.">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-primary" @click="searchShops">검색</button>
                                    </div>
                                </div>
                                <small class="form-text">* 거래처명, 거래처 연락처, 배송 담당자명을 입력하면 자동으로 검색됩니다.</small>
                            </div>
                        </div>
                        <div style="height: 430px;">
                            <table class="table table-middle text-center table-hover" id="shopTable">
                                <colgroup>
                                    <col style="width: 10%">
                                    <col>
                                    <col style="width: 20%">
                                    <col style="width: 15%">
                                    <col style="width: 15%">
                                </colgroup>
                                <thead class="thead-light">
                                <tr>
                                    <th>#</th>
                                    <th>거래처명</th>
                                    <th>거래처 연락처</th>
                                    <th>배송 담당자</th>
                                    <th>거래처 선택</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="shops.length === 0">
                                    <td colspan="5">
                                        일치하는 거래처를 찾을 수 없습니다.
                                    </td>
                                </tr>
                                <tr v-for="(shop, index) in shops">
                                    <td>{{ index + 1 }}</td>
                                    <td>{{ shop.name }}</td>
                                    <td>{{ shop.shopOwner.phone }}</td>
                                    <td>{{ shop.deliverer.fullName }}</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-secondary" @click="selectShop(shop)">선택
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
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
                                            <td>{{ Number(product.buyPrice).toLocaleString() }}</td>
                                            <td>{{ Number(product.sellPrice).toLocaleString() }}</td>
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
                                                <p><span class="unit">{{ orderProduct.product.unit }}</span> / <span class="country">{{ orderProduct.product.country }}</span></p>
                                                <div class="form-inline">
                                                    <select class="form-control form-control-sm" v-model="orderProduct.price" style="width: 37%;">
                                                        <option v-bind:value="orderProduct.primaryPrice">기본 단가</option>
                                                        <option v-for="groupPrice in orderProduct.product.groupPrices" v-bind:value="groupPrice.price">{{ groupPrice.priceGroup.name }}</option>
                                                    </select>
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
                                            <div class="col-6 text-right">{{ Number(total_amount).toLocaleString() }}원</div>
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
        components: {NumberInput},
        data() {
            return {
                shops: [],
                shop_keyword: '',
                selected_shop: null,
                selected_shop_name: '',
                deliveryType: 'direct',
                requestDate: '',
                salesMans: [],
                deliverers: [],
                selected_deliverer_id: null,
                selected_salesman_id: null,
                requestMemo: '',
                memo: '',
                products_modal_title: '',
                categories: [],
                selected_category_id: null,
                subcategories: [],
                selected_subcategory_id: null,
                product_keyword: '',
                products: [],
                prev_products: [],
                orderProducts: [],
                total_amount: 0,
                total_qty: 0,
                showCartTable: false
            }
        },
        mounted() {
            let self = this;
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            this.requestDate = this.formatDate(tomorrow);

            $('#requestDate').datepicker({
                dateFormat: 'yy-mm-dd',
                onSelect: function (selectedDate, datePicker) {
                    self.requestDate = selectedDate;
                }
            });

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
        },
        methods: {
            showShopModal: function () {
                this.searchShops();
                $('#selectShops').modal('show');
            },
            showProductsModal: function () {
                if (this.selected_shop === null) {
                    toastr.error('거래처 선택을 먼저 해주셔야 상품 선택이 가능합니다.');
                } else {
                    this.searchProducts();
                    this.products_modal_title = (this.deliveryType === 'direct' ? '직배송' : '택배 배송') + ' 상품 검색 및 선택';
                    $('#selectProducts').modal('show');
                }
            },
            searchShops: function () {
                axios.get('/shops/get_shops?keyword=' + this.shop_keyword)
                    .then(response => response.data)
                    .then(data => {
                        this.shops = data.shops;
                    })
                    .catch(error => {
                        console.log(error);
                    });
            },
            selectShop: function (shop) {
                this.selected_shop = shop;
                this.selected_shop_name = this.selected_shop.name;
                this.orderProducts = [];
                $('#selectShops').modal('hide');
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
                        deliveryType: (this.deliveryType === 'direct' ? 1 : 2),
                        shop: this.selected_shop.id
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        this.products = data.products;
                        this.products.forEach(product => {
                            let spIdx = product.shopPrices.findIndex(x => x.shop.id === this.selected_shop.id);
                            if (spIdx !== -1) {
                                product.sellPrice = product.shopPrices[spIdx].price;
                            }
                        });
                        this.prev_products = data.prev_products;
                        if (data.prev_products.length > 0) {
                            this.prev_products.forEach(product => {
                                this.addToOrderProduct(product);
                            });
                            this.showCartTable = true;
                        }
                    })
                    .catch(err => {
                        console.log(err);
                    })
            },
            addToOrderProduct: function (product) {
                let opId = this.orderProducts.findIndex(op => op.productId === product.id);
                if (opId !== -1) {
                    let orderProduct = this.orderProducts[opId];
                    orderProduct.qty = orderProduct.qty + 1;
                    this.$set(this.orderProducts, opId, orderProduct);
                } else {
                    let orderProduct = {};
                    console.log(product);
                    orderProduct.product = Object.assign({}, product);
                    // this.$set(orderProduct, 'product', product);
                    orderProduct.productId = orderProduct.product.id;
                    let spIdx = product.shopPrices.findIndex(x => x.shop.id === this.selected_shop.id);
                    if (spIdx === -1) {
                        orderProduct.primaryPrice = product.sellPrice;
                    } else {
                        orderProduct.primaryPrice = product.shopPrices[spIdx].price;
                    }
                    orderProduct.price = orderProduct.primaryPrice;
                    orderProduct.qty = 0;
                    this.orderProducts.push(orderProduct);
                }
            },
            selectedProduct: function (product) {
                this.addToOrderProduct(product);
            },
            resetOrderProducts: function () {
                this.orderProducts = [];
            },
            removeOrderProduct: function (index) {
                this.orderProducts.splice(index, 1);
            },
            saveOrderProducts: function () {
                this.showCartTable = true;
                $('#selectProducts').modal('hide');
            },
            submitForm: function () {
                let token = $("meta[name='_csrf']").attr("content");

                if (!this.selected_shop || !this.selected_deliverer_id || this.orderProducts.length === 0) {
                    toastr.error('필수 입력 사항들을 입력하세요.');
                    return false;
                }

                axios.post('/orders/return_store', {
                    shopId: this.selected_shop.id,
                    deliveryType: this.deliveryType,
                    requestDate: this.requestDate,
                    delivererId: this.selected_deliverer_id,
                    salesmanId: this.selected_salesman_id,
                    memo: this.memo,
                    orderProducts: this.orderProducts
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
                    this.total_qty = total_qty;
                    this.total_amount = total_funds;
                }
            },
            deliveryType: function (val) {
                this.orderProducts = [];
            }
        }
    }
</script>
