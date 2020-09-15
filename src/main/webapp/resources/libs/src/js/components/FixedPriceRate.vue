<template>
    <div>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">정액/정률 사용 설정 <span data-toggle="modal" data-target="#infoModal"
                                                         class="fa fa-info-circle"></span></h5>
                <div class="form-group row">
                    <label class="col-form-label col-lg-2">설정 여부</label>
                    <div class="col-lg-10">
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="is_fixed" value="true" id="flat1">
                            <label class="custom-control-label" for="flat1">설정</label>
                        </div>
                        <div class="custom-control custom-control-inline custom-radio">
                            <input type="radio" class="custom-control-input" v-model="is_fixed" value="false" id="flat2">
                            <label class="custom-control-label" for="flat2">비설정</label>
                        </div>
                        <small class="form-text">
                            * 타이틀 우측의 ?를 누르면 자세한 내용을 확인하실수 있습니다.
                        </small>
                    </div>
                </div>
            </div>
        </div>
        <div class="card mb-4" id="price-rate">
        <div class="card-body">
            <h5 class="card-title">단가 그룹/상품 카테고리</h5>
            <p>* 정률값( (매입단가/100) &times; 설정% )의 소숫점은 올림 처리하고, 나머지 원 단위는 절삭합니다.</p>
            <p>* 상품 카테고리별로 정액/정률을 별도 설정하시려면 <a href="/categories">상품 관리 > 카테고리 설정</a>에서 먼저 사용여부를 설정해
                주세요.</p>
            <form method="post" action="/prices/fixed-price-rate">
                <div class="table-responsive">
                    <table class="table table-middle">
                        <thead class="thead-light">
                        <tr>
                            <th style="width: 100px;">카테고리</th>
                            <th>직배송 단가</th>
                            <th>택배배송 단가</th>
                            <th>기본 단가</th>
                            <th v-for="priceGroup in priceGroups">{{priceGroup.name}}</th>
                            <th style="width: 100px;">삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>기본 설정</td>
                            <td>
                                <div class="input-group input-group-sm" style="width: 150px;">
                                    <NumberInput v-model="mainPriceRates.direct" class="form-control text-right"/>
                                    <div class="input-group-append">
                                        <select class="form-control form-control-sm">
                                            <option value="won">원</option>
                                            <option value="%">%</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="input-group input-group-sm" style="width: 150px;">
                                    <NumberInput v-model="mainPriceRates.parcel" class="form-control text-right"/>
                                    <div class="input-group-append">
                                        <select class="form-control form-control-sm">
                                            <option value="won">원</option>
                                            <option value="%">%</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="input-group input-group-sm" style="width: 150px;">
                                    <NumberInput v-model="mainPriceRates.sell" class="form-control text-right"/>
                                    <div class="input-group-append">
                                        <select class="form-control form-control-sm">
                                            <option value="won">원</option>
                                            <option value="%">%</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td v-for="priceGroup in priceGroups">
                                <div class="input-group input-group-sm" style="width: 150px;">
                                    <NumberInput v-model="mainPriceRates.direct" class="form-control text-right"/>
                                    <div class="input-group-append">
                                        <select class="form-control form-control-sm">
                                            <option value="won">원</option>
                                            <option value="%">%</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>
    <div class="form-group">
        <a href="/prices" class="btn btn-secondary">이전 목록으로</a>
        <button class="btn btn-primary">설정 저장</button>
    </div>
    <div class="modal fade" id="infoModal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <div class="modal-title text-light">정액/정률 사용법 안내</div>
                    <button class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p class="text-primary">
                        * 설정 여부를 설정으로 놓고, 단가그룹별로 설정값을 세팅한 뒤, 적용버튼을 누르면 사용처리가 됩니다.<br>
                        * 해당 기능의 적용 범위는 아래와 같습니다.
                    </p>
                    <table class="table">
                        <thead class="thead-light">
                        <tr>
                            <th style="width: 25%;">적용부분</th>
                            <th style="width: 75%;">설명</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th>상품 대량 등록/수정</th>
                            <td>
                                상품 관리에서 상품 엑셀 대량 등록/수정시 입력하신 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.
                            </td>
                        </tr>
                        <tr>
                            <th>상품 등록/수정</th>
                            <td>상품 관리에서 새로운 상품 등록 및 기존 상품 수정 시 입력하신 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.</td>
                        </tr>
                        <tr>
                            <th>상품 단가 일괄 적용</th>
                            <td>
                                단가 관리 &gt; 상품 단가 일괄 적용 메뉴에서 매입단가 입력 및 단가 일괄 수정 시 입력한 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    </div>
</template>

<script>
    import NumberInput from "./NumberInput";
    export default {
        name: "FixedPriceRate",
        components: {NumberInput},
        data: function() {
            return {
                is_fixed: false,
                priceGroups: [],
                mainPriceRates : {
                    direct: 0,
                    parcel: 0,
                    sell: 0,
                    groupRates: []
                }
            }
        },
        mounted() {
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
        },
    }
</script>

<style scoped>

</style>