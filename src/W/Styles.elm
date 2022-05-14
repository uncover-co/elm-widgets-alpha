module W.Styles exposing (globalStyles)

{-|

@docs globalStyles

-}

import Html as H exposing (Html)


{-| -}
globalStyles : Html msg
globalStyles =
    H.node "style"
        []
        [ H.text """.ew{box-sizing:border-box;margin:0;padding:0}.ew.ew-relative{position:relative}.ew.ew-focusable{cursor:pointer}.ew.ew-focusable:focus{outline:3px solid var(--tmspc-focus);outline-offset:2px}.ew.ew-focusable:disabled{cursor:default;outline:none}.ew.ew-focusable:-moz-read-only{cursor:default}.ew.ew-focusable:read-only{cursor:default}.ew.ew-h-space>*+*{margin-left:8px}.ew.ew-v-space>*+*{margin-top:8px}.ew.ew-text{font-family:var(--tmspc-font-text)}.ew.ew-loading-dots{display:inline-block;height:var(--size);position:relative;width:var(--size)}.ew.ew-loading-dots>div{-webkit-animation-timing-function:cubic-bezier(0,1,1,0);animation-timing-function:cubic-bezier(0,1,1,0);background:var(--color);border-radius:calc(var(--size)*.2);height:calc(var(--size)*.2);position:absolute;top:calc(var(--size)*.4);width:calc(var(--size)*.2)}.ew.ew-loading-dots>div:first-child{-webkit-animation:ew-loading-dots-1 .6s infinite;animation:ew-loading-dots-1 .6s infinite;left:0}.ew.ew-loading-dots>div:nth-child(2){left:0}.ew.ew-loading-dots>div:nth-child(2),.ew.ew-loading-dots>div:nth-child(3){-webkit-animation:ew-loading-dots-2 .6s infinite;animation:ew-loading-dots-2 .6s infinite}.ew.ew-loading-dots>div:nth-child(3){left:calc(var(--size)*.4)}.ew.ew-loading-dots>div:nth-child(4){-webkit-animation:ew-loading-dots-3 .6s infinite;animation:ew-loading-dots-3 .6s infinite;left:calc(var(--size)*.8)}@-webkit-keyframes ew-loading-dots-1{0%{transform:scale(0)}to{transform:scale(1)}}@keyframes ew-loading-dots-1{0%{transform:scale(0)}to{transform:scale(1)}}@-webkit-keyframes ew-loading-dots-2{0%{transform:translate(0)}to{transform:translate(calc(var(--size)*.4))}}@keyframes ew-loading-dots-2{0%{transform:translate(0)}to{transform:translate(calc(var(--size)*.4))}}@-webkit-keyframes ew-loading-dots-3{0%{transform:scale(1)}to{transform:scale(0)}}@keyframes ew-loading-dots-3{0%{transform:scale(1)}to{transform:scale(0)}}.ew.ew-loading-ripples{display:inline-block;height:var(--size);position:relative;width:var(--size)}.ew.ew-loading-ripples>div{-webkit-animation:ew-loading-ripples 1.2s cubic-bezier(0,.2,.8,1) infinite;animation:ew-loading-ripples 1.2s cubic-bezier(0,.2,.8,1) infinite;border:calc(var(--size)*.06) solid var(--color);border-radius:50%;opacity:1;position:absolute}.ew.ew-loading-ripples>div:nth-child(2){-webkit-animation-delay:-.6s;animation-delay:-.6s}@-webkit-keyframes ew-loading-ripples{0%{height:0;left:calc(var(--size)*.5);opacity:1;top:calc(var(--size)*.5);width:0}to{height:var(--size);left:0;opacity:0;top:0;width:var(--size)}}@keyframes ew-loading-ripples{0%{height:0;left:calc(var(--size)*.5);opacity:1;top:calc(var(--size)*.5);width:0}to{height:var(--size);left:0;opacity:0;top:0;width:var(--size)}}.ew.ew-btn{align-items:center;background:var(--background);border:none;border-radius:4px;color:var(--color);cursor:pointer;display:inline-flex;font-family:var(--tmspc-font-text);font-size:12px;font-weight:700;height:36px;justify-content:center;letter-spacing:.05em;line-height:1em;padding:0 18px;text-decoration:none;text-transform:uppercase;transition:box-shadow .15s,background .15s}.ew.ew-btn:disabled{opacity:.4;pointer-events:none}.ew.ew-btn:hover{box-shadow:0 0 4px var(--shadow);opacity:.9}.ew.ew-btn:active:not(:disabled){opacity:.75}.ew.ew-btn.ew-m-outlined{background:transparent;border:3px solid var(--background);box-shadow:none;color:var(--background);padding:0 16px}.ew.ew-btn.ew-m-outlined:hover{box-shadow:0 0 4px var(--shadow)}.ew.ew-btn.ew-m-invisible{background:transparent;border-color:transparent;box-shadow:none;color:var(--background);overflow:hidden;position:relative}.ew.ew-btn.ew-m-invisible:before{background:var(--background);bottom:0;content:"";display:block;left:0;opacity:0;position:absolute;right:0;top:0;transition:opacity .2s}.ew.ew-btn.ew-m-invisible:hover:before{opacity:.1}.ew.ew-field{background:var(--tmspc-background);font-family:var(--tmspc-font-text);padding:16px}.ew.ew-field+.ew.ew-field{border-top:2px solid rgb(var(--tmspc-background-light-ch)/.5)}.ew.ew-field-main.ew-m-align-right{align-items:center;display:flex;justify-content:space-between}.ew.ew-field-main.ew-m-align-right .ew-field-label{padding-bottom:0}.ew.ew-field-main.ew-m-align-right .ew-field-label-wrapper{padding-right:16px;width:40%}.ew.ew-field-main.ew-m-align-right .ew-field-input{display:flex;justify-content:flex-start;width:60%}.ew.ew-field-label{font-weight:400;padding-bottom:8px}.ew.ew-field-label,.ew.ew-field-label-footer{color:var(--tmspc-baseline-light);font-family:var(--tmspc-font-text);font-size:14px}.ew.ew-field-label-footer{padding-top:2px}.ew.ew-field-message{background-color:rgb(var(--tmspc-baseline-light-ch)/.1);border-radius:4px;color:var(--tmspc-baseline);margin-top:8px;padding:12px}.ew.ew-field-message.ew-m-success{background-color:rgb(var(--tmspc-success-light-ch)/.1);color:var(--tmspc-success)}.ew.ew-field-message.ew-m-warning{background-color:rgb(var(--tmspc-warning-light-ch)/.1);color:var(--tmspc-warning)}.ew.ew-field-message.ew-m-danger{background-color:rgb(var(--tmspc-danger-light-ch)/.1);color:var(--tmspc-danger)}.ew.ew-input{align-items:center;-webkit-appearance:none;-moz-appearance:none;appearance:none;background:var(--tmspc-background);border:none;border:2px solid var(--tmspc-background-light);border-radius:4px;box-shadow:none;color:var(--tmspc-baseline);display:flex;font-family:var(--tmspc-font-text);font-size:16px;line-height:1em;min-height:48px;padding:8px 12px;position:relative;width:100%}.ew.ew-input:disabled{background:rgb(var(--tmspc-background-light-ch)/.5)}.ew.ew-input:invalid:not(:focus){border-color:var(--tmspc-warning-light)}textarea.ew.ew-input{padding:14px 12px;resize:vertical}.ew.ew-select-wrapper{position:relative}.ew.ew-select::-ms-expand{display:none}.ew.ew-select-icon{border:2px solid var(--tmspc-background-light);border-left:none;border-top:none;height:10px;margin-top:-6px;position:absolute;right:20px;top:50%;transform:rotate(45deg);width:10px}[type=checkbox].ew.ew-checkbox,[type=radio].ew.ew-radio-buttons--item-input{-webkit-appearance:none;-moz-appearance:none;appearance:none;background:var(--tmspc-background);border:2px solid var(--tmspc-background-light);box-shadow:none;display:grid;height:28px;place-content:center;width:28px}[type=checkbox].ew.ew-checkbox:before,[type=radio].ew.ew-radio-buttons--item-input:before{background-color:var(--color);content:"";display:block;height:16px;transform:scale(0);transition:transform .12s ease-in-out;width:16px}[type=checkbox].ew.ew-checkbox:hover,[type=radio].ew.ew-radio-buttons--item-input:hover{opacity:.9}[type=checkbox].ew.ew-checkbox:active,[type=radio].ew.ew-radio-buttons--item-input:active{opacity:.75}[type=checkbox].ew.ew-checkbox:focus,[type=radio].ew.ew-radio-buttons--item-input:focus{box-shadow:none}[type=checkbox].ew.ew-checkbox:checked,[type=radio].ew.ew-radio-buttons--item-input:checked{background:var(--tmspc-background)}[type=checkbox].ew.ew-checkbox:checked:before,[type=radio].ew.ew-radio-buttons--item-input:checked:before{transform:scale(1)}[type=checkbox].ew.ew-checkbox.ew-is-disabled:active,[type=checkbox].ew.ew-checkbox.ew-is-disabled:hover,[type=checkbox].ew.ew-checkbox.ew-is-read-only:active,[type=checkbox].ew.ew-checkbox.ew-is-read-only:hover,[type=radio].ew.ew-radio-buttons--item-input.ew-is-disabled:active,[type=radio].ew.ew-radio-buttons--item-input.ew-is-disabled:hover,[type=radio].ew.ew-radio-buttons--item-input.ew-is-read-only:active,[type=radio].ew.ew-radio-buttons--item-input.ew-is-read-only:hover{opacity:1}[type=checkbox].ew.ew-checkbox.ew-is-disabled,[type=radio].ew.ew-radio-buttons--item-input.ew-is-disabled{background-color:rgb(var(--tmspc-background-light-ch)/.5);pointer-events:none}[type=checkbox].ew.ew-checkbox.ew-is-disabled:checked:before,[type=radio].ew.ew-radio-buttons--item-input.ew-is-disabled:checked:before{opacity:.5}[type=checkbox].ew.ew-checkbox.ew-is-read-only,[type=radio].ew.ew-radio-buttons--item-input.ew-is-read-only{background-color:var(--tmspc-background)}.ew.ew-checkbox{border-radius:4px}.ew.ew-checkbox:before{border-radius:2px}.ew.ew-radio-buttons.ew-m-vertical{display:flex;flex-direction:column}.ew.ew-radio-buttons.ew-is-disabled .ew-radio-buttons--item,.ew.ew-radio-buttons.ew-is-read-only .ew-radio-buttons--item{cursor:default}.ew.ew-radio-buttons.ew-is-disabled .ew-radio-buttons--item-label,.ew.ew-radio-buttons.ew-is-read-only .ew-radio-buttons--item-label{color:var(--tmspc-baseline-light)}.ew.ew-radio-buttons--item{align-items:center;cursor:pointer;display:inline-flex;padding:8px 0}.ew.ew-radio-buttons--item+.ew.ew-radio-buttons--item{padding-left:20px}.ew.ew-radio-buttons.ew-m-vertical .ew.ew-radio-buttons--item+.ew.ew-radio-buttons--item{padding-left:0}.ew.ew-radio-buttons--item-input{border-radius:14px}.ew.ew-radio-buttons--item-input:before{border-radius:8px}.ew.ew-radio-buttons--item-label{color:var(--tmspc-baseline);font-family:var(--tmspc-font-text);padding-left:12px}.ew.ew-slider-wrapper{background-color:var(--tmspc-background);padding-top:8px}.ew.ew-slider-value-wrapper{display:flex;font-family:var(--tmspc-font-text);height:24px;justify-content:center;overflow:hidden;position:relative;text-align:center}.ew.ew-slider-value-wrapper:after{border-top:1px solid var(--tmspc-background-light);content:"";display:block;left:0;margin-top:-3px;position:absolute;right:0;top:50%}.ew.ew-slider-value{color:var(--tmspc-baseline);font-size:14px;position:relative}.ew.ew-slider-bounds,.ew.ew-slider-value{background-color:var(--tmspc-background);padding:0 8px;z-index:1}.ew.ew-slider-bounds{color:var(--tmspc-background-light);font-size:12px;position:absolute;top:1px}.ew.ew-slider-bounds.ew-m-min{left:0}.ew.ew-slider-bounds.ew-m-max{right:0}.ew.ew-slider{-webkit-appearance:none;-moz-appearance:none;appearance:none;background:var(--tmspc-background);margin:0;position:relative;width:100%;z-index:2}.ew.ew-slider:focus{outline:none}.ew.ew-slider::-webkit-slider-runnable-track{background:var(--tmspc-background-light);box-shadow:none;cursor:pointer;height:3px;margin:12px 8px;-webkit-transition:.2s;transition:.2s;width:100%}.ew.ew-slider:focus::-webkit-slider-runnable-track{background:rgb(var(--tmspc-baseline-light-ch)/.6)}.ew.ew-slider::-moz-range-track{background:var(--tmspc-background-light);box-shadow:none;cursor:pointer;height:3px;margin:12px 8px;width:100%}.ew.ew-slider::-webkit-slider-thumb{-webkit-appearance:none;appearance:none;background:var(--color);border-radius:50%;cursor:pointer;height:20px;margin-top:-9px;-webkit-transition:box-shadow .12s;transition:box-shadow .12s;width:20px}.ew.ew-slider::-webkit-slider-thumb:hover{box-shadow:0 0 0 12px var(--shadow)}.ew.ew-slider:active::-webkit-slider-thumb{box-shadow:0 0 0 8px var(--shadow);-webkit-transition:box-shadow 0ms;transition:box-shadow 0ms}.ew.ew-slider::-moz-range-thumb{-moz-appearance:none;appearance:none;background:var(--color);border-radius:50%;cursor:pointer;height:20px;margin-top:-9px;-moz-transition:.4s;transition:.4s;width:20px}.ew.ew-slider::-moz-range-thumb:hover{box-shadow:0 0 0 12px var(--shadow)}.ew.ew-slider:active::-moz-range-thumb{box-shadow:0 0 0 8px var(--shadow);-moz-transition:box-shadow 0ms;transition:box-shadow 0ms}.ew.ew-slider:disabled{pointer-events:none}.ew.ew-autocomplete{position:relative}.ew.ew-autocomplete-loading{--color:var(--tmspc-background-light);background:var(--tmspc-background);bottom:4px;position:absolute;right:4px;top:4px;width:48px}.ew.ew-autocomplete-loading,.ew.ew-modal{align-items:center;display:flex;justify-content:center}.ew.ew-modal{bottom:0;flex-direction:column;left:0;padding:20px;position:fixed;right:0;top:0}.ew.ew-modal.ew-m-absolute{position:absolute}.ew.ew-modal-background{background:rgba(0,0,0,.4);bottom:0;left:0;opacity:.2;position:absolute;right:0;top:0;transition:opacity .2s}.ew.ew-modal-content{background:var(--tmspc-background);border-radius:8px;box-shadow:0 2px 20px rgba(0,0,0,.1);max-height:80%;max-width:960px;overflow:auto;position:relative;width:100%}.ew.ew-modal-close{shadow:none;align-self:flex-end;background:transparent;border:none;color:var(--tmspc-background);cursor:pointer;margin-top:-32px;padding:8px;pointer-events:none;position:relative}.ew.ew-modal.ew-m-can-close .ew-modal-background:hover{cursor:pointer;opacity:.15}.ew.ew-modal.ew-m-can-close .ew-modal-background:hover+.ew-modal-close{transform:scale(.9)}.ew.ew-modal.ew-m-can-close .ew-modal-background:hover:active+.ew-modal-close{transform:scale(.7)}.ew.ew-data-row{background:var(--tmspc-background)}.ew.ew-data-row,.ew.ew-data-row-main{align-items:center;display:flex;padding:8px}.ew.ew-data-row-main{-webkit-appearance:none;-moz-appearance:none;appearance:none;background:none;border:none;border-radius:4px;box-shadow:none;color:var(--tmspc-baseline);flex-grow:1;font-family:var(--tmspc-font-text);font-size:16px;text-align:left;text-decoration:none;width:100%}.ew.ew-data-row-main.ew-m-button:hover,.ew.ew-data-row-main.ew-m-link:hover{background:rgb(var(--tmspc-background-light-ch)/.2);cursor:pointer}.ew.ew-data-row-main.ew-m-button:active,.ew.ew-data-row-main.ew-m-link:active{background:rgb(var(--tmspc-background-light-ch)/.4)}.ew.ew-data-row-left{padding:8px 12px 8px 0}.ew.ew-data-row-main-main{flex-grow:1}.ew.ew-data-row-footer,.ew.ew-data-row-header{color:var(--tmspc-baseline-light);font-size:14px}.ew.ew-data-row-header{padding-bottom:2px}.ew.ew-data-row-footer{padding-top:1px}.ew.ew-data-row-actions{flex-shrink:0;padding-left:8px}""" ]