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
                            <select class="form-control w-25 mr-2" v-model="category_id" @change="changeCategory(category_id)">
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
                <tr v-for="(productPrice, index) in productPrices" :key="index">
                    <th>{{ productPrice.priceGroupName === 'direct' ? '직배송 단가' : (productPrice.priceGroupName === 'parcel' ? '택배배송 단가' : (productPrice.priceGroupName === 'main' ? '기본 단가' : productPrice.priceGroupName)) }}</th>
                    <td>
                        <div class="input-group w-25">
                            <NumberInput :disabled="use_special_price_rate" v-model="productPrice.price" class="form-control price-group text-right" v-bind:placeholder="productPrice.priceGroupName"/>
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
        name: "ProductEdit",
        components: {NumberInput},
        data() {
            return {
                id: 0,
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
                productPrices: [],
                use_special_price_rate: false
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
            });

            let currentUrl = window.location.pathname;
            axios.get(`${currentUrl}/data`)
                .then(res => res.data)
                .then(data => {
                    console.log(data);
                    this.categories = data.categories;
                    this.priceGroups = data.priceGroups;
                    this.suppliers = data.suppliers;

                    let product = data.product;
                    this.id = product.id;
                    this.erpCode = product.erpCode;
                    this.productName = product.name;
                    if (product.category) {
                        this.category_id = product.category.id;
                    }
                    if (product.subCategory) {
                        this.subcategory_id = product.subCategory.id;
                        let selected_category = this.categories.find(category => category.id === this.category_id);
                        this.subcategories = selected_category.children;
                    }
                    this.makerName = product.makerName;
                    this.country = product.country;
                    this.standard = product.standard;
                    this.unit = product.unit;
                    this.tax = product.tax;
                    this.deliveryType = product.deliveryType;
                    this.shippingMethod = product.shippingMethod;
                    this.useDecimal = product.useDecimal;
                    this.imageUrl = product.imageUrl;
                    this.message = product.message;
                    if (product.supplier) {
                        this.supplier_id = product.supplier.id;
                    }
                    this.buyPrice = product.buyPrice;
                    this.use_special_price_rate = data.use_special_price_rate;
                    this.productPrices = data.productPrices;
                    this.productPrices.forEach(productPrice => {
                        productPrice.priceGroupName = productPrice.priceGroup.name;
                        productPrice.priceGroupId = productPrice.priceGroup.id;
                    });
                    if (this.use_special_price_rate === true) {
                        this.fixed_price_rates = data.fixed_price_rates;
                    }
                })
                .catch(error => {
                    console.error(error);
                })
        },
        methods: {
            saveProduct: function () {
                if (!this.productName) {
                    toastr.error('상품명을 입력하세요.');
                    return false;
                }
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/products/update', {
                    id: this.id,
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
                    productPriceInputs: this.productPrices
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
            changeCategory: function (category_id) {
                if (category_id === null) {
                    this.subcategories = [];
                    this.subcategory_id = null;
                } else {
                    let selected_category = this.categories.find(category => category.id === category_id);
                    this.subcategories = selected_category.children;
                    this.subcategory_id = null;
                }
            }
        },
        watch: {
            category_id: function (category_id) {
                if (this.use_special_price_rate === true) {
                    if (category_id === null) {
                        let selectedPriceRates = this.fixed_price_rates.filter(x => {
                            return x.category === null;
                        });
                        this.productPrices = [];
                        selectedPriceRates.forEach(priceRate => {
                            let price = 0;
                            if (priceRate.unit === 'p') {
                                price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                            } else if (priceRate.unit === 'w') {
                                price = this.buyPrice + priceRate.rate;
                            }
                            this.productPrices.push({
                                priceGroupId: priceRate.priceGroup.id,
                                priceGroupName: priceRate.priceGroup.name,
                                price: price,
                                unit: priceRate.unit,
                                rate: priceRate.rate,
                            });
                        });
                    } else {
                        let selected_category = this.categories.find(category => category.id === category_id);
                        if (selected_category.useIndividual === true) {
                            let selectedPriceRates = this.fixed_price_rates.filter(x => {
                                return x.category && x.category.id === category_id;
                            });
                            this.productPrices = [];
                            selectedPriceRates.forEach(priceRate => {
                                let price = 0;
                                if (priceRate.unit === 'p') {
                                    price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                                } else if (priceRate.unit === 'w') {
                                    price = this.buyPrice + priceRate.rate;
                                }
                                this.productPrices.push({
                                    priceGroupId: priceRate.priceGroup.id,
                                    priceGroupName: priceRate.priceGroup.name,
                                    price: price,
                                    unit: priceRate.unit,
                                    rate: priceRate.rate,
                                });
                            });
                        } else {
                            let selectedPriceRates = this.fixed_price_rates.filter(x => {
                                return x.category === null;
                            });
                            this.productPrices = [];
                            selectedPriceRates.forEach(priceRate => {
                                let price = 0;
                                if (priceRate.unit === 'p') {
                                    price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                                } else if (priceRate.unit === 'w') {
                                    price = this.buyPrice + priceRate.rate;
                                }
                                this.productPrices.push({
                                    priceGroupId: priceRate.priceGroup.id,
                                    priceGroupName: priceRate.priceGroup.name,
                                    price: price,
                                    unit: priceRate.unit,
                                    rate: priceRate.rate,
                                });
                            });
                        }
                    }
                }

                if (category_id === null) {
                    this.subcategories = [];
                    this.subcategory_id = null;
                } else {
                    let selected_category = this.categories.find(category => category.id === category_id);
                    this.subcategories = selected_category.children;
                    this.subcategory_id = null;
                }
            },
            subcategory_id: function (subcategory_id) {
                if (this.use_special_price_rate === true) {
                    if (subcategory_id) {
                        let selected_subcategory = this.subcategories.find(category => category.id === subcategory_id);
                        if (selected_subcategory.useIndividual === true) {
                            let selectedPriceRates = this.fixed_price_rates.filter(x => {
                                return x.category && x.category.id === selected_subcategory.id;
                            });
                            this.productPrices = [];
                            selectedPriceRates.forEach(priceRate => {
                                let price = 0;
                                if (priceRate.unit === 'p') {
                                    price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                                } else if (priceRate.unit === 'w') {
                                    price = this.buyPrice + priceRate.rate;
                                }
                                this.productPrices.push({
                                    priceGroupId: priceRate.priceGroup.id,
                                    priceGroupName: priceRate.priceGroup.name,
                                    price: price,
                                    unit: priceRate.unit,
                                    rate: priceRate.rate,
                                });
                            });
                        } else {
                            let selected_category = this.categories.find(category => category.id === this.category_id);
                            if (selected_category.useIndividual === true) {
                                let selectedPriceRates = this.fixed_price_rates.filter(x => {
                                    return x.category && x.category.id === selected_category.id;
                                });
                                this.productPrices = [];
                                selectedPriceRates.forEach(priceRate => {
                                    let price = 0;
                                    if (priceRate.unit === 'p') {
                                        price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                                    } else if (priceRate.unit === 'w') {
                                        price = this.buyPrice + priceRate.rate;
                                    }
                                    this.productPrices.push({
                                        priceGroupId: priceRate.priceGroup.id,
                                        priceGroupName: priceRate.priceGroup.name,
                                        price: price,
                                        unit: priceRate.unit,
                                        rate: priceRate.rate,
                                    });
                                });
                            } else {
                                let selectedPriceRates = this.fixed_price_rates.filter(x => {
                                    return x.category === null;
                                });
                                this.productPrices = [];
                                selectedPriceRates.forEach(priceRate => {
                                    let price = 0;
                                    if (priceRate.unit === 'p') {
                                        price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                                    } else if (priceRate.unit === 'w') {
                                        price = this.buyPrice + priceRate.rate;
                                    }
                                    this.productPrices.push({
                                        priceGroupId: priceRate.priceGroup.id,
                                        priceGroupName: priceRate.priceGroup.name,
                                        price: price,
                                        unit: priceRate.unit,
                                        rate: priceRate.rate,
                                    });
                                });
                            }
                        }
                    } else {
                        let selectedPriceRates = this.fixed_price_rates.filter(x => {
                            return x.category === null;
                        });
                        this.productPrices = [];
                        selectedPriceRates.forEach(priceRate => {
                            let price = 0;
                            if (priceRate.unit === 'p') {
                                price = Math.round(this.buyPrice * (priceRate.rate / 100 + 1));
                            } else if (priceRate.unit === 'w') {
                                price = this.buyPrice + priceRate.rate;
                            }
                            this.productPrices.push({
                                priceGroupId: priceRate.priceGroup.id,
                                priceGroupName: priceRate.priceGroup.name,
                                price: price,
                                unit: priceRate.unit,
                                rate: priceRate.rate,
                            });
                        });
                    }
                }
            },
            buyPrice: function(buyPrice) {
                this.productPrices.forEach(productPrice => {
                    if (productPrice.unit === 'p') {
                        productPrice.price = Math.round(buyPrice * (productPrice.rate / 100 + 1));
                    } else if (productPrice.unit === 'w') {
                        productPrice.price = buyPrice + productPrice.rate;
                    }
                });
            }
        }
    }
</script>

<style scoped>

</style>