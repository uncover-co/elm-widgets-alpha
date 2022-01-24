module ElmWidgets.Styles exposing (..)

import Html as H exposing (Html)

globalStyles : Html msg
globalStyles =
    H.node "style"
        []
        [ H.text """.ew{box-sizing:border-box;margin:0;padding:0}.ew.ew-relative{position:relative}.ew.ew-focusable{cursor:pointer}.ew.ew-focusable:focus{outline:3px solid var(--tmspc-focus);outline-offset:3px}.ew.ew-focusable:disabled{cursor:default}.ew.ew-h-space>*+*{margin-left:8px}.ew.ew-v-space>*+*{margin-top:8px}.ew.ew-text{font-family:var(--tmspc-font-text)}.ew.ew-loading-dots{display:inline-block;height:var(--size);position:relative;width:var(--size)}.ew.ew-loading-dots>div{-webkit-animation-timing-function:cubic-bezier(0,1,1,0);animation-timing-function:cubic-bezier(0,1,1,0);background:var(--color);border-radius:calc(var(--size)*.2);height:calc(var(--size)*.2);position:absolute;top:calc(var(--size)*.4);width:calc(var(--size)*.2)}.ew.ew-loading-dots>div:first-child{-webkit-animation:ew-loading-dots-1 .6s infinite;animation:ew-loading-dots-1 .6s infinite;left:0}.ew.ew-loading-dots>div:nth-child(2){left:0}.ew.ew-loading-dots>div:nth-child(2),.ew.ew-loading-dots>div:nth-child(3){-webkit-animation:ew-loading-dots-2 .6s infinite;animation:ew-loading-dots-2 .6s infinite}.ew.ew-loading-dots>div:nth-child(3){left:calc(var(--size)*.4)}.ew.ew-loading-dots>div:nth-child(4){-webkit-animation:ew-loading-dots-3 .6s infinite;animation:ew-loading-dots-3 .6s infinite;left:calc(var(--size)*.8)}@-webkit-keyframes ew-loading-dots-1{0%{transform:scale(0)}to{transform:scale(1)}}@keyframes ew-loading-dots-1{0%{transform:scale(0)}to{transform:scale(1)}}@-webkit-keyframes ew-loading-dots-2{0%{transform:translate(0)}to{transform:translate(calc(var(--size)*.4))}}@keyframes ew-loading-dots-2{0%{transform:translate(0)}to{transform:translate(calc(var(--size)*.4))}}@-webkit-keyframes ew-loading-dots-3{0%{transform:scale(1)}to{transform:scale(0)}}@keyframes ew-loading-dots-3{0%{transform:scale(1)}to{transform:scale(0)}}.ew.ew-loading-ripple{display:inline-block;height:var(--size);position:relative;width:var(--size)}.ew.ew-loading-ripple>div{-webkit-animation:ew-loading-ripple 1.2s cubic-bezier(0,.2,.8,1) infinite;animation:ew-loading-ripple 1.2s cubic-bezier(0,.2,.8,1) infinite;border:calc(var(--size)*.06) solid var(--color);border-radius:50%;opacity:1;position:absolute}.ew.ew-loading-ripple>div:nth-child(2){-webkit-animation-delay:-.6s;animation-delay:-.6s}@-webkit-keyframes ew-loading-ripple{0%{height:0;left:calc(var(--size)*.5);opacity:1;top:calc(var(--size)*.5);width:0}to{height:var(--size);left:0;opacity:0;top:0;width:var(--size)}}@keyframes ew-loading-ripple{0%{height:0;left:calc(var(--size)*.5);opacity:1;top:calc(var(--size)*.5);width:0}to{height:var(--size);left:0;opacity:0;top:0;width:var(--size)}}.ew.ew-btn{align-items:center;border:none;border-radius:var(--tmspc-border-radius);color:var(--color);cursor:pointer;display:inline-flex;font-family:var(--tmspc-font-text);font-size:12px;font-weight:700;height:36px;justify-content:center;letter-spacing:.05em;line-height:1em;padding:0 18px;text-decoration:none;text-transform:uppercase;transition:box-shadow .15s,background .15s}.ew.ew-btn:disabled{opacity:.4;pointer-events:none}.ew.ew-btn:hover{opacity:.9}.ew.ew-btn:active:not(:disabled){opacity:.75}.ew.ew-btn.ew-m-primary{background:var(--background)}.ew.ew-btn.ew-m-primary:hover{box-shadow:0 0 8px var(--shadow)}.ew.ew-btn.ew-m-primary.ew-is-danger{background:var(--tmspc-danger-base);color:var(--tmspc-danger-contrast)}.ew.ew-btn.ew-m-primary.ew-is-danger:hover{box-shadow:0 0 8px var(--tmspc-danger-shadow)}.ew.ew-btn.ew-m-primary.ew-is-danger:active{box-shadow:none}.ew.ew-btn.ew-m-primary.ew-is-confirm{background:var(--tmspc-success-base);color:var(--tmspc-success-contrast)}.ew.ew-btn.ew-m-primary.ew-is-confirm:hover{box-shadow:0 0 8px var(--tmspc-success-shadow)}.ew.ew-btn.ew-m-primary.ew-is-confirm:active{box-shadow:none}.ew.ew-btn.ew-m-outlined{background:transparent;border:3px solid var(--color);box-shadow:none;color:var(--color);padding:0 16px}.ew.ew-btn.ew-m-outlined:hover{box-shadow:0 0 4px var(--shadow)}.ew.ew-btn.ew-m-invisible{background:transparent;border-color:transparent;box-shadow:none;color:var(--color);overflow:hidden;position:relative}.ew.ew-btn.ew-m-invisible>.ew.ew-bg{background:var(--background);bottom:0;left:0;opacity:0;position:absolute;right:0;top:0;transition:.15s}.ew.ew-btn.ew-m-invisible:hover>.ew.ew-bg{opacity:1}.ew.ew-field{background:var(--tmspc-background-base);font-family:var(--tmspc-font-text);padding:16px}.ew.ew-field+.ew.ew-field{border-top:2px solid var(--tmspc-background-tint)}.ew.ew-field-main.ew-m-align-right{align-items:center;display:flex;justify-content:space-between}.ew.ew-field-main.ew-m-align-right .ew-field-label{padding-bottom:0}.ew.ew-field-main.ew-m-align-right .ew-field-label-wrapper{padding-right:16px;width:40%}.ew.ew-field-main.ew-m-align-right .ew-field-input{display:flex;justify-content:flex-start;width:60%}.ew.ew-field-label{color:var(--tmspc-color-base);font-family:var(--tmspc-font-text);font-size:16px;font-weight:400;padding-bottom:8px}.ew.ew-field-label-footer{color:var(--tmspc-color-light);font-family:var(--tmspc-font-text);font-size:14px;padding-top:2px}.ew.ew-field-message{background-color:var(--tmspc-color-tint);border-radius:var(--tmspc-border-radius);color:var(--tmspc-color-base);margin-top:8px;padding:12px}.ew.ew-field-message.ew-m-success{background-color:var(--tmspc-success-tint);color:var(--tmspc-success-dark)}.ew.ew-field-message.ew-m-warning{background-color:var(--tmspc-warning-tint);color:var(--tmspc-warning-dark)}.ew.ew-field-message.ew-m-danger{background-color:var(--tmspc-danger-tint);color:var(--tmspc-danger-dark)}.ew.ew-input{align-items:center;-webkit-appearance:none;-moz-appearance:none;appearance:none;background:var(--tmspc-background-base);border:none;border:2px solid var(--tmspc-background-dark);border-radius:var(--tmspc-border-radius);box-shadow:none;color:var(--tmspc-color-base);display:flex;font-family:var(--tmspc-font-text);font-size:16px;line-height:1em;min-height:48px;padding:8px 12px;position:relative;width:100%}.ew.ew-input:disabled{background:var(--tmspc-background-tint)}.ew.ew-input:invalid:not(:focus){border-color:var(--tmspc-warning-base)}.ew.ew-select-wrapper{position:relative}.ew.ew-select::-ms-expand{display:none}.ew.ew-select-icon{border:2px solid var(--tmspc-background-dark);border-left:none;border-top:none;height:10px;margin-top:-6px;position:absolute;right:20px;top:50%;transform:rotate(45deg);width:10px}.ew.ew-checkbox-input,.ew.ew-radio-buttons--item-input{-webkit-appearance:none;-moz-appearance:none;appearance:none;border:2px solid var(--tmspc-background-dark);display:grid;height:28px;place-content:center;width:28px}.ew.ew-checkbox-input:before,.ew.ew-radio-buttons--item-input:before{background-color:var(--color);content:"";display:block;height:16px;transform:scale(0);transition:transform .12s ease-in-out;width:16px}.ew.ew-checkbox-input:hover,.ew.ew-radio-buttons--item-input:hover{opacity:.9}.ew.ew-checkbox-input:active,.ew.ew-radio-buttons--item-input:active{opacity:.75}.ew.ew-checkbox-input:checked:before,.ew.ew-radio-buttons--item-input:checked:before{transform:scale(1)}.ew.ew-checkbox-input:disabled,.ew.ew-radio-buttons--item-input:disabled{background-color:var(--tmspc-background-tint);border-color:var(--tmspc-background-dark);pointer-events:none}.ew.ew-checkbox-input:disabled:hover:before,.ew.ew-radio-buttons--item-input:disabled:hover:before{transform:scale(0)}.ew.ew-checkbox.is-disabled .ew-checkbox-input,.ew.ew-radio-buttons.is-disabled .ew-radio-buttons--item-input{border-color:var(--tmspc-background-dark)}.ew.ew-checkbox{display:inline-block;padding:8px 0}.ew.ew-checkbox-input{border-radius:var(--tmspc-border-radius)}.ew.ew-radio-buttons.m-vertical{display:flex;flex-direction:column}.ew.ew-radio-buttons.is-disabled .ew-radio-buttons--item{cursor:default}.ew.ew-radio-buttons.is-disabled .ew-radio-buttons--item-label{color:var(--tmspc-color-light)}.ew.ew-radio-buttons--item{align-items:center;cursor:pointer;display:inline-flex;padding:8px 0}.ew.ew-radio-buttons--item+.ew.ew-radio-buttons--item{padding-left:20px}.ew.ew-radio-buttons.m-vertical .ew.ew-radio-buttons--item+.ew.ew-radio-buttons--item{padding-left:0}.ew.ew-radio-buttons--item-input{border-radius:14px}.ew.ew-radio-buttons--item-input:before{border-radius:8px}.ew.ew-radio-buttons--item-label{color:var(--tmspc-color-base);font-family:var(--tmspc-font-text);padding-left:12px}.ew.ew-range{-webkit-appearance:none;-moz-appearance:none;appearance:none;background:var(--tmspc-background-base);margin:0;width:100%}.ew.ew-range:focus{outline:none}.ew.ew-range::-webkit-slider-runnable-track{background:var(--tmspc-background-dark);box-shadow:none;cursor:pointer;height:3px;margin:12px 8px;width:100%}.ew.ew-range::-moz-range-track{background:var(--tmspc-background-dark);box-shadow:none;cursor:pointer;height:3px;margin:12px 8px;width:100%}.ew.ew-range::-webkit-slider-thumb{-webkit-appearance:none;appearance:none;background:var(--color);border-radius:50%;cursor:pointer;height:20px;margin-top:-9px;width:20px}.ew.ew-range::-moz-range-thumb{-moz-appearance:none;appearance:none;background:var(--color);border-radius:50%;cursor:pointer;height:20px;margin-top:-9px;width:20px}.ew.ew-range:focus::-webkit-slider-thumb{outline:3px solid var(--tmspc-focus);outline-offset:3px}.ew.ew-range:focus::-moz-range-thumb{outline:3px solid var(--tmspc-focus);outline-offset:3px}.ew.ew-range:disabled{pointer-events:none}.ew.ew-autocomplete{position:relative}.ew.ew-autocomplete-loading{--color:var(--tmspc-background-light);background:var(--tmspc-background-base);bottom:4px;position:absolute;right:4px;top:4px;width:48px}.ew.ew-autocomplete-loading,.ew.ew-modal{align-items:center;display:flex;justify-content:center}.ew.ew-modal{bottom:0;flex-direction:column;left:0;padding:20px;position:fixed;right:0;top:0}.ew.ew-modal.ew-m-absolute{position:absolute}.ew.ew-modal-background{background:var(--tmspc-color-light);bottom:0;left:0;opacity:.2;position:absolute;right:0;top:0;transition:opacity .2s}.ew.ew-modal-content{background:var(--tmspc-background-base);border-radius:var(--tmspc-border-radius-large);box-shadow:0 2px 20px var(--tmspc-background-shadow);max-height:80%;max-width:960px;overflow:auto;position:relative;width:100%}.ew.ew-modal-close{shadow:none;align-self:flex-end;background:transparent;border:none;color:var(--tmspc-background-base);cursor:pointer;margin-top:-32px;padding:8px;pointer-events:none;position:relative}.ew.ew-modal.ew-m-can-close .ew-modal-background:hover{cursor:pointer;opacity:.15}.ew.ew-modal.ew-m-can-close .ew-modal-background:hover+.ew-modal-close{transform:scale(.9)}.ew.ew-modal.ew-m-can-close .ew-modal-background:hover:active+.ew-modal-close{transform:scale(.7)}.ew.ew-data-row{background:var(--tmspc-background-base)}.ew.ew-data-row,.ew.ew-data-row-main{align-items:center;display:flex;padding:8px}.ew.ew-data-row-main{-webkit-appearance:none;-moz-appearance:none;appearance:none;background:none;border:none;border-radius:var(--tmspc-border-radius);box-shadow:none;color:var(--tmspc-color-base);flex-grow:1;font-family:var(--tmspc-font-text);font-size:16px;text-align:left;text-decoration:none;width:100%}.ew.ew-data-row-main.ew-m-button:hover,.ew.ew-data-row-main.ew-m-link:hover{background:var(--tmspc-background-tint);cursor:pointer}.ew.ew-data-row-main.ew-m-button:active,.ew.ew-data-row-main.ew-m-link:active{background:var(--tmspc-background-light)}.ew.ew-data-row-left{padding:8px 12px 8px 0}.ew.ew-data-row-main-main{flex-grow:1}.ew.ew-data-row-footer,.ew.ew-data-row-header{color:var(--tmspc-color-light);font-size:14px}.ew.ew-data-row-header{padding-bottom:2px}.ew.ew-data-row-footer{padding-top:1px}.ew.ew-data-row-actions{flex-shrink:0;padding-left:8px}""" ]