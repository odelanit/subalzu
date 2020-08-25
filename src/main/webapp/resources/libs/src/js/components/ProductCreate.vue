<template>
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">기본 정보</h5>
            <table class="table table-bordered form-table mb-5">
                <tbody class="thead-light">
                <tr>
                    <th>상품 코드</th>
                    <td colspan="3">
                        <input class="form-control w-50" v-model="erpCode" placeholder="상품코드를 입력하세요."/>
                        <small class="form-text">기존에 쓰시는 ERP 상품 코드(단축코드)를 입력하세요. 없으면 입력하지
                            않아도 됩니다.</small>
                    </td>
                </tr>
                <tr>
                    <th class="required"><span>상품명</span></th>
                    <td colspan="3">
                        <input v-model="productName" class="form-control w-50" placeholder="상품명을 입력하세요."/>
                    </td>
                </tr>
                <tr>
                    <th>카테고리</th>
                    <td colspan="3">
                        <div class="d-flex">
                            <select class="form-control w-25 mr-2" v-model="category_id">
                                <option v-bind:value="null">1차 카테고리</option>
                                <option v-for="category in categories" v-bind:value="category.id">{{ category.name }}</option>
                            </select>
                            <select class="form-control w-25" v-model="subcategory_id">
                                <option v-bind:value="null">2차 카테고리</option>
                                <option v-for="category in subcategories" v-bind:value="category.id">{{ category.name }}</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>제조사</th>
                    <td>
                        <input class="form-control" v-model="makerName" placeholder="예: 농심"/>
                    </td>
                    <th>원산지</th>
                    <td>
                        <input class="form-control" v-model="country" placeholder="예: 국내산"/>
                    </td>
                </tr>
                <tr>
                    <th>판매규격</th>
                    <td>
                        <input class="form-control" v-model="standard" placeholder="예: 250g * 30"/>
                    </td>
                    <th>판매단위</th>
                    <td>
                        <input class="form-control" v-model="unit" placeholder="예: BOX/EA"/>
                    </td>
                </tr>
                <tr>
                    <th class="required"><span>과세구분</span></th>
                    <td>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="tax" value="true" id="tax-radio1"/>
                            <label class="custom-control-label" for="tax-radio1">과세</label>
                        </div>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="tax" value="false" id="tax-radio2"/>
                            <label class="custom-control-label" for="tax-radio2">면세</label>
                        </div>
                    </td>
                    <th class="required"><span>배송유형</span></th>
                    <td>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="deliveryType" value="0" id="delivery_type1"/>
                            <label class="custom-control-label" for="delivery_type1">전체</label>
                        </div>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="deliveryType" value="1" id="delivery_type2"/>
                            <label class="custom-control-label" for="delivery_type2">직배송</label>
                        </div>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="deliveryType" value="2" id="delivery_type3"/>
                            <label class="custom-control-label" for="delivery_type3">택배배송</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th class="required"><span>발주유형</span></th>
                    <td>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="shippingMethod" value="manual" id="shipping1"/>
                            <label class="custom-control-label" for="shipping1">수동 발주</label>
                        </div>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="shippingMethod" value="automatic" id="shipping2"/>
                            <label class="custom-control-label" for="shipping2">자동 발주</label>
                        </div>
                    </td>
                    <th>수량 소수점 사용</th>
                    <td>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="useDecimal" value="false" id="use_decimal1"/>
                            <label class="custom-control-label" for="use_decimal1">미사용</label>
                        </div>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="useDecimal" value="true" id="use_decimal2"/>
                            <label class="custom-control-label" for="use_decimal2">사용</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>상품이미지</th>
                    <td colspan="3">
                        <div class="dropzone" id="productImage">
                            <img :src="imageUrl" id="img-preview" class="img-preview" alt=""/>
                        </div>
                        <input type="hidden" v-model="imageUrl">
                    </td>
                </tr>
                <tr>
                    <th>상품 메세지(구매 시 전달사항)</th>
                    <td colspan="3">
                        <input v-model="message" class="form-control"/>
                        <small class="form-text">거래처 주문 화면의 해당 상품 목록에 내용이 보여집니다. (공백 포함. 최대
                            50자 입력 가능)</small>
                    </td>
                </tr>
                </tbody>
            </table>
            <h5 class="card-title">매입 정보</h5>
            <table class="table table-bordered form-table mb-5">
                <tbody class="thead-light">
                <tr>
                    <th>대표 매입처</th>
                    <td>
                        <select class="form-control w-25" v-model="supplier_id">
                            <option v-bind:value="null">선택하세요.</option>
                            <option v-for="supplier in suppliers" v-bind:value="supplier.id">{{ supplier.name }}</option>
                        </select>
                        <small class="form-text">
                            신규 매입처 등록은 매입처 관리에서 추가할수 있습니다.<br>
                            <a href="/suppliers/create" class="text-primary"> 매입처 등록 바로가기</a>
                        </small>
                    </td>
                </tr>
                <tr>
                    <th>매입 단가</th>
                    <td>
                        <div class="input-group w-25">
                            <NumberInput v-model="buyPrice" class="form-control text-right" placeholder="매입단가"/>
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <h5 class="card-title">단가 정보</h5>
            <table class="table table-bordered form-table mb-5">
                <tbody class="thead-light">
                <tr>
                    <th class="required"><span>직배송 단가</span></th>
                    <td>
                        <div class="input-group w-25">
                            <NumberInput v-model="directPrice" class="form-control text-right price-group" placeholder="직배송 단가" />
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th class="required"><span>택배배송 단가</span></th>
                    <td>
                        <div class="input-group w-25">
                            <NumberInput v-model="parcelPrice" class="form-control text-right price-group" placeholder="택배배송 단가" />
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th class="required"><span>기본 단가</span></th>
                    <td>
                        <div class="input-group w-25">
                            <NumberInput v-model="sellPrice" class="form-control price-group text-right" placeholder="택배배송 단가"/>
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr v-for="groupPrice in groupPrices">
                    <th>{{ groupPrice.priceGroupName }}</th>
                    <td>
                        <div class="input-group w-25">
                            <NumberInput v-model="groupPrice.price" class="form-control price-group text-right" v-bind:placeholder="groupPrice.priceGroupName"/>
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="form-group text-center">
                <a href="/products" class="btn btn-outline-secondary">목록으로</a>
                <button class="btn btn-primary" @click="saveProduct">등록하기</button>
            </div>
        </div>
    </div>
</template>

<script>
    import NumberInput from "./NumberInput";
    export default {
        name: "ProductCreate",
        components: {NumberInput},
        data() {
            return {
                erpCode: '',
                productName: '',
                category_id: null,
                selected_category: {},
                subcategory_id: null,
                makerName: '',
                country: '',
                standard: '',
                unit: '',
                tax: false,
                deliveryType: 0,
                shippingMethod: 'manual',
                useDecimal: false,
                imageUrl: '',
                message: '',
                supplier_id: null,
                suppliers: [],
                directPrice: 0,
                parcelPrice: 0,
                buyPrice: 0,
                sellPrice: 0,
                categories: [],
                subcategories: [],
                priceGroups: [],
                groupPrices: [],
            }
        },
        mounted() {
            Dropzone.autoDiscover = false;
            let self = this;

            new Dropzone('#productImage', {
                url: '/upload',
                paramName: 'upload',
                acceptedFiles: 'image/*',
                addRemoveLinks: true,
                maxfilesexceeded: function (file) {
                    this.removeAllFiles();
                    this.addFile(file);
                },
                success: function (file, response) {
                    self.imageUrl = response.url;
                },
                removedfile: function (file) {
                    self.imageUrl = '';
                    var _ref;
                    return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
                },
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
                }
            });

            axios.interceptors.request.use(function (config) {
                $("#overlay").fadeIn(300);
                return config;
            }, function (error) {
                setTimeout(function(){
                    $("#overlay").fadeOut(300);
                },500);
                return Promise.reject(error);
            });
            axios.interceptors.response.use(function (response) {
                setTimeout(function(){
                    $("#overlay").fadeOut(300);
                },500);
                return response;
            })

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
                    this.priceGroups.forEach(priceGroup => {
                        let groupPrice = {};
                        groupPrice.priceGroupId = priceGroup.id;
                        groupPrice.priceGroupName = priceGroup.name;
                        groupPrice.price = 0;
                        this.groupPrices.push(groupPrice);
                    });
                })
                .catch(err => {
                    console.log(err);
                });
            axios.get('/suppliers/data')
                .then(res => res.data)
                .then(data => {
                    this.suppliers = data.suppliers;
                })
                .catch(err => {
                    console.log(err);
                })
        },
        methods: {
            saveProduct: function () {
                if (!this.productName) {
                    toastr.error('상품명을 입력하세요.');
                    return false;
                }
                if (!this.directPrice) {
                    toastr.error('직배송 단가를 입력하세요.');
                    return false;
                }
                if (!this.parcelPrice) {
                    toastr.error('택배 배송 단가를 입력하세요.');
                    return false;
                }
                if (!this.sellPrice) {
                    toastr.error('기본 단가를 입력하세요.');
                    return false;
                }
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/products/store', {
                    erpCode: this.erpCode,
                    name: this.productName,
                    categoryId: this.category_id,
                    subcategoryId: this.subcategory_id,
                    makerName: this.makerName,
                    country: this.country,
                    standard: this.standard,
                    unit: this.unit,
                    tax: this.tax,
                    deliveryType: this.deliveryType,
                    shippingMethod: this.shippingMethod,
                    useDecimal: this.useDecimal,
                    imageUrl: this.imageUrl,
                    message: this.message,
                    supplierId: this.supplier_id,
                    buyPrice: this.buyPrice,
                    directPrice: this.directPrice,
                    parcelPrice: this.parcelPrice,
                    sellPrice: this.sellPrice,
                    groupPrices: this.groupPrices
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        window.location.href = '/products';
                    })
                    .catch(error => {
                        console.log(error);
                    });
            },
        },
        watch: {
            category_id: function (category_id) {
                if (category_id === null) {
                    this.subcategories = [];
                    this.subcategory_id = null;
                } else {
                    let selected_category = this.categories.find(category => category.id === category_id);
                    this.subcategories = selected_category.children;
                    this.subcategory_id = null;
                }
            }
        }
    }
</script>

<style scoped>

</style>