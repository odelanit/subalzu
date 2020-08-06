<template>
    <input type="text" v-model="displayValue" @blur="isInputActive = false" @focus="isInputActive = true">
</template>

<script>
    export default {
        name: "NumberInput",
        props: ["value"],
        data: function () {
            return {
                isInputActive: false
            }
        },
        computed: {
            displayValue: {
                get: function () {
                    if (this.isInputActive) {
                        return this.value.toString();
                    } else {
                        return this.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    }
                },
                set: function(modifiedValue) {
                    let newValue = parseFloat(modifiedValue.replace(/[^\d\.]/g, ""));
                    if (isNaN(newValue)) {
                        newValue = 0;
                    }
                    this.$emit('input', newValue);
                }
            }
        }
    }
</script>

<style scoped>

</style>