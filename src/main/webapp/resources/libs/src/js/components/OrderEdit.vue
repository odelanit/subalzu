<template>
    <div>
        <div class="card mb-4">
            <div class="card-body">
                <div class="py-5">
                    <h5 class="text-center">주문번호 <span class="h4 font-weight-bold">{{ orderCode }}</span>상세내역입니다.</h5>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <button class="btn btn-sm btn-outline-danger" id="order_delete" @click="deleteOrder">
                            <i class="fa fa-trash"></i> 주문삭제
                        </button>
                        <button v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'" class="btn btn-sm btn-warning"
                                @click="cancelOrder">주문취소
                        </button>
                    </div>
                    <div class="col-md-6 text-right">
                        <button class="btn btn-sm btn-outline-secondary" @click="printOrder" type="button">
                            <i class="fa fa-scroll"></i>
                            거래명세표
                        </button>
                        <button v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'"
                                class="btn btn-sm btn-outline-danger" @click="changeReleaseStatus('rejected')">
                            <i class="fa fa-times"></i>출고거절
                        </button>
                        <button v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'"
                                class="btn btn-sm btn-outline-primary" @click="changeReleaseStatus('completed')">
                            <i class="fa fa-check"></i>출고완료
                        </button>
                        <button v-if="releaseStatus === 'completed' && orderStatus !== 'return_received'"
                                class="btn btn-sm btn-outline-warning" @click="showReturnModal">
                            반품접수
                        </button>
<!--                        <button v-if="orderStatus === 'return_received'"-->
<!--                                class="btn btn-sm btn-outline-success" @click="completeReturn">-->
<!--                            반품완료-->
<!--                        </button>-->
                    </div>
                </div>
                <hr>
                <h5 class="card-title">주문 정보
                    <span class="text-primary">
                                        (주문상태:
                        <template v-if="orderStatus === 'completed'">
                            주문완료
                        </template>
                        <template v-if="orderStatus === 'modified'">
                            주문변경
                        </template>
                        <template v-else-if="orderStatus === 'canceled'">
                            주문취소
                        </template>
                    </span>
                    <span class="mx-1">/</span>
                    <span class="text-success">
                        출고상태:
                        <template v-if="releaseStatus === 'progress'">
                            출고전
                        </template>
                        <template v-else-if="releaseStatus === 'rejected'">
                            출고거절
                        </template>
                        <template v-else-if="releaseStatus === 'completed'">
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
                        <td>{{ orderCode }}</td>
                        <th>거래처</th>
                        <td>{{ selected_shop.name }}</td>
                    </tr>
                    <tr>
                        <th>주문일자</th>
                        <td>{{ createdAt }}</td>
                        <th>담당자/연락처</th>
                        <td>{{ selected_shop.shopOwner.fullName }} / {{ selected_shop.shopOwner.phone }}</td>
                    </tr>
                    <tr>
                        <th>거래처 주소</th>
                        <td colspan="3">{{ selected_shop.addressLine1 }} {{ selected_shop.addressLine2 }}</td>
                    </tr>
                    <tr>
                        <th>결제수단</th>
                        <td>
                            <template v-if="selected_shop.paymentMethod === 'credit'">외상결제</template>
                            <template v-else-if="selected_shop.paymentMethod === 'prepaid'">예치금</template>
                        </td>
                        <th>총 주문금액</th>
                        <td>{{ Number(total_amount).toLocaleString() }}</td>
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
                            <template v-if="deliveryType === 'parcel'">택배배송</template>
                            <template v-else-if="deliveryType === 'direct'">직배송</template>
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
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="required"><span>배송 담당자</span></th>
                        <td>
                            <select v-model="selected_deliverer_id" class="form-control">
                                <option v-bind:value="null">-- 선택 --</option>
                                <option v-for="deliverer in deliverers" v-bind:value="deliverer.id">
                                    {{ deliverer.fullName }}
                                </option>
                            </select>
                        </td>
                        <th>영업 담당자</th>
                        <td>
                            <select class="form-control form-control-sm" v-model="selected_salesman_id">
                                <option v-bind:value="null">-- 선택 --</option>
                                <option v-for="salesman in salesMans" v-bind:value="salesman.id">
                                    {{ salesman.fullName }}
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>요청사항</th>
                        <td colspan="3">
                            {{ requestMemo }}
                        </td>
                    </tr>
                    <tr>
                        <th>메모</th>
                        <td colspan="3">
                            <textarea class="form-control" rows="3" v-model="memo"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h5 class="card-title">주문 상품 목록</h5>
                <div class="row mb-2">
                    <div class="col-6">
                        <span></span>
                    </div>
                    <div class="col-6 text-right">
                        <button class="btn btn-sm btn-outline-primary float-right" v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'" @click="showProductsModal">상품추가
                        </button>
                    </div>
                </div>
                <table class="table table-sm text-center table-middle table-hover mb-5">
                    <colgroup>
                        <col style="width: 5%">
                        <col>
                        <col>
                        <col>
                        <col style="width: 8%">
                        <col style="width: 12%">
                        <col style="width: 12%">
                        <col v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'" style="width: 8%">
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
                        <th v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'">삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(orderProduct, index) in orderProducts">
                        <td>{{ index + 1 }}</td>
                        <td>{{ orderProduct.product.name }}</td>
                        <td>{{ orderProduct.product.standard }}<br>({{ orderProduct.product.unit }})</td>
                        <td>{{ orderProduct.product.makerName }}<br>({{ orderProduct.product.country }})</td>
                        <td>
                            <template v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'">
                                <input class="form-control form-control-sm text-center" type="number" v-model.number="orderProduct.qty">
                            </template>
                            <template v-else>
                                {{ orderProduct.qty }}
                            </template>
                        </td>
                        <td>
                            <template v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'">
                                <NumberInput class="form-control form-control-sm text-right"
                                       v-model.number="orderProduct.price" />
                            </template>
                            <template v-else>
                                {{ Number(orderProduct.price).toLocaleString() }}
                            </template>
                        </td>
                        <td>{{ Number(orderProduct.qty * orderProduct.price).toLocaleString() }}</td>
                        <td v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'">
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
                        <td class="text-center">{{ total_qty }}</td>
                        <td></td>
                        <td>{{ Number(total_amount).toLocaleString() }}</td>
                        <td v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'"></td>
                    </tr>
                    </tfoot>
                </table>
                <template v-if="orderStatus === 'return_received' || orderStatus === 'return_completed'">
                    <h5 class="card-title">반품 상품 목록</h5>
                    <table class="table table-sm text-center table-middle table-hover mb-5">
                        <colgroup>
                            <col style="width: 5%">
                            <col>
                            <col>
                            <col>
                            <col style="width: 8%">
                            <col style="width: 12%">
                            <col style="width: 12%">
                        </colgroup>
                        <thead class="thead-light">
                        <tr>
                            <th>#</th>
                            <th>상품명</th>
                            <th>규격<br>(단위)</th>
                            <th>제조사<br>(원산지)</th>
                            <th>반품 수량</th>
                            <th>단가(원)</th>
                            <th>합계금액(원)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(orderProduct, index) in orderProducts" v-if="orderProduct.reQty > 0">
                            <td>{{ index + 1 }}</td>
                            <td>{{ orderProduct.product.name }}</td>
                            <td>{{ orderProduct.product.standard }}<br>({{ orderProduct.product.unit }})</td>
                            <td>{{ orderProduct.product.makerName }}<br>({{ orderProduct.product.country }})</td>
                            <td>
                                {{ orderProduct.reQty }}
                            </td>
                            <td>
                                {{ Number(orderProduct.price).toLocaleString() }}
                            </td>
                            <td>{{ Number(orderProduct.reQty * orderProduct.price).toLocaleString() }}</td>
                        </tr>
                        </tbody>
                        <tfoot class="thead-light">
                        <tr>
                            <th>합계</th>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="text-center">{{ total_reQty }}</td>
                            <td></td>
                            <td>{{ Number(total_refunds).toLocaleString() }}</td>
                        </tr>
                        </tfoot>
                    </table>
                </template>
                <div class="form-group text-center">
                    <a href="/orders" class="btn btn-dark">목록으로</a>
                    <template v-if="orderStatus !== 'canceled' && releaseStatus === 'progress'">
                        <button class="btn btn-outline-primary" @click="submitForm">주문 변경 완료</button>
                    </template>
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
                                    <div class="col-6">선택상품 목록<span>(전체 {{ orderProducts.length }}건)</span></div>
                                    <div class="col-6 text-right">
                                        <button class="btn btn-sm btn-outline-primary" @click="resetOrderProducts"><i
                                                class="fa fa-undo"></i></button>
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
        <div class="modal fade" id="returnProducts" v-if="releaseStatus === 'completed'">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header bg-danger">
                        <div class="modal-title text-light">
                            반품 접수
                        </div>
                        <button class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <h6>주문 상품 목록</h6>
                        <table class="table text-center table-middle">
                            <thead class="thead-light">
                            <tr>
                                <th>#</th>
                                <th>상품코드</th>
                                <th>상품명</th>
                                <th>카테고리</th>
                                <th>규격(단위)</th>
                                <th>제조사(원산지)</th>
                                <th>주문수량</th>
                                <th class="w-10">반품수량</th>
                                <th>단가</th>
                                <th>총액</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="orderProduct in orderProducts">
                                <td>{{ orderProduct.id }}</td>
                                <td>{{ orderProduct.product.erpCode }}</td>
                                <td>{{ orderProduct.product.name }}</td>
                                <td>
                                    <template v-if="orderProduct.product.category">
                                        {{ orderProduct.product.category.name }}
                                    </template>
                                </td>
                                <td>
                                    {{ orderProduct.product.standard }}
                                    <template v-if="orderProduct.product.unit">
                                        <br>({{ orderProduct.product.unit }})
                                    </template>
                                </td>
                                <td>
                                    {{ orderProduct.product.makerName }}
                                    <template v-if="orderProduct.product.country">
                                        <br>({{ orderProduct.product.country }})
                                    </template>
                                </td>
                                <td class="qty">{{ orderProduct.qty }}</td>
                                <td>
                                    <input class="form-control form-control-sm text-center" type="number" v-model="orderProduct.reQty">
                                </td>
                                <td>{{ Number(orderProduct.price).toLocaleString() }}</td>
                                <td>{{ Number(orderProduct.price * (orderProduct.qty - orderProduct.reQty)).toLocaleString() }}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
                        <button class="btn btn-outline-primary" @click="receiveReturn">접수완료</button>
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
                orderId: '',
                orderCode: '',
                createdAt: '',
                orderStatus: '',
                releaseStatus: '',
                shop_keyword: '',
                selected_shop: {
                    shopOwner: {}
                },
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
                orderProducts: [],
                total_amount: 0,
                total_qty: 0,
                total_refunds: 0,
                total_reQty: 0,
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

            let currentUrl = window.location.pathname;

            axios.get(`${currentUrl}/ajax`)
                .then(res => res.data)
                .then(data => {
                    this.orderId = data.order.id;
                    this.orderCode = data.order.orderCode;
                    this.createdAt = data.order.createdAt;
                    this.orderStatus = data.order.orderStatus;
                    this.releaseStatus = data.order.releaseStatus;

                    this.selected_shop = data.order.shop;
                    this.deliveryType = data.order.deliveryType;
                    this.selected_deliverer_id = data.order.deliverer.id;
                    if (data.order.salesMan) {
                        this.selected_salesman_id = data.order.salesMan.id;
                    }
                    this.requestDate = data.order.requestDate;
                    this.requestMemo = data.order.requestMemo;
                    this.orderProducts = data.order.orderProducts;
                    this.orderProducts.forEach(orderProduct => {
                        this.total_amount += orderProduct.qty * orderProduct.price;
                        orderProduct.productId = orderProduct.product.id;
                        let spIdx = orderProduct.product.shopPrices.findIndex(x => x.shop.id === this.selected_shop.id);
                        if (spIdx === -1) {
                            orderProduct.primaryPrice = orderProduct.product.sellPrice;
                        } else {
                            orderProduct.primaryPrice = orderProduct.product.shopPrices[spIdx].price;
                        }

                    });
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
                    this.products_modal_title = (this.deliveryType === 'direct' ? '직배송' : '택배 배송') + ' 상품 검색 및 선택';
                    this.searchProducts();
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
                        deliveryType: (this.deliveryType === 'direct' ? 1 : 2)
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
                    let spIdx = product.shopPrices.findIndex(x => x.shop.id === this.selected_shop.id);
                    if (spIdx === -1) {
                        orderProduct.primaryPrice = product.sellPrice;
                    } else {
                        orderProduct.primaryPrice = product.shopPrices[spIdx].price;
                    }
                    orderProduct.price = orderProduct.primaryPrice;
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
                this.showCartTable = true;
                $('#selectProducts').modal('hide');
            },
            submitForm: function () {
                let token = $("meta[name='_csrf']").attr("content");

                if (!this.selected_shop || !this.selected_deliverer_id || this.orderProducts.length === 0) {
                    toastr.error('필수 입력 사항들을 입력하세요.');
                    return false;
                }

                axios.post('/orders/update', {
                    id: this.orderId,
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
            },
            deleteOrder: function () {
                window.location.href = '/orders/' + this.orderId + '/delete';
            },
            cancelOrder: function () {
                window.location.href = '/orders/' + this.orderId + '/cancel';
            },
            printOrder: function () {
                window.open('/orders/print_order?ids='+this.orderId, "거래명세표", "width=1350, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
            },
            changeReleaseStatus: function (status) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post(`/orders/change_status`, {
                    id: this.orderId,
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
            showReturnModal: function () {
                $('#returnProducts').modal('show');
            },
            receiveReturn: function () {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/orders/receive_return', {
                    id: this.orderId,
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
                    .catch(error => {
                        console.log(error);
                    })
            },
            completeReturn: function() {
                console.log('OK');
            }
        },
        watch: {
            orderProducts: {
                deep: true,
                handler(orderProducts) {
                    let total_funds = 0, total_qty = 0, total_refunds = 0, total_reQty = 0;
                    orderProducts.forEach(item => {
                        if (item.qty < item.reQty) {
                            toastr.error('반품은 주문 수량 내에서만 가능합니다.');
                            item.reQty = item.qty;
                            return false;
                        }
                        total_funds += item.price * item.qty;
                        total_refunds += item.price * item.reQty;
                        total_qty += item.qty;
                        total_reQty += item.reQty;
                    });
                    this.total_qty = total_qty;
                    this.total_amount = total_funds;
                    this.total_refunds = total_refunds;
                    this.total_reQty = total_reQty;
                }
            }
        }
    }
</script>
