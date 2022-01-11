module ElmWidgets.Styles exposing (..)

import Html as H exposing (Html)

globalStyles : Html msg
globalStyles =
    H.node "style"
        []
        [ H.text """.ew{box-sizing:border-box;margin:0;padding:0}.ew.ew-relative{position:relative}.ew.ew-focusable{cursor:pointer}.ew.ew-focusable:focus{outline:3px solid var(--tmspc-focus);outline-offset:3px}.ew.ew-h-space>*+*{margin-left:8px}.ew.ew-v-space>*+*{margin-top:8px}.ew.ew-btn,.ew.ew-text{font-family:var(--tmspc-font-text)}.ew.ew-btn{align-items:center;border:none;border-radius:var(--tmspc-border-radius);color:var(--color);cursor:pointer;display:inline-flex;font-size:12px;font-weight:700;height:36px;justify-content:center;letter-spacing:.05em;line-height:1em;padding:0 18px;text-decoration:none;text-transform:uppercase;transition:box-shadow .15s,background .15s}.ew.ew-btn:disabled{opacity:.4;pointer-events:none}.ew.ew-btn:hover{opacity:.9}.ew.ew-btn:active:not(:disabled){opacity:.75}.ew.ew-btn.ew-m-primary{background:var(--background)}.ew.ew-btn.ew-m-primary:hover{box-shadow:0 0 8px var(--shadow)}.ew.ew-btn.ew-m-primary.ew-is-danger{background:var(--tmspc-danger-base);color:var(--tmspc-danger-contrast)}.ew.ew-btn.ew-m-primary.ew-is-danger:hover{box-shadow:0 0 8px var(--tmspc-danger-shadow)}.ew.ew-btn.ew-m-primary.ew-is-danger:active{box-shadow:none}.ew.ew-btn.ew-m-primary.ew-is-confirm{background:var(--tmspc-success-base);color:var(--tmspc-success-contrast)}.ew.ew-btn.ew-m-primary.ew-is-confirm:hover{box-shadow:0 0 8px var(--tmspc-success-shadow)}.ew.ew-btn.ew-m-primary.ew-is-confirm:active{box-shadow:none}.ew.ew-btn.ew-m-outlined{background:transparent;border:3px solid var(--color);box-shadow:none;color:var(--color);padding:0 16px}.ew.ew-btn.ew-m-outlined:hover{box-shadow:0 0 4px var(--shadow)}.ew.ew-btn.ew-m-invisible{background:transparent;border-color:transparent;box-shadow:none;color:var(--color);overflow:hidden;position:relative}.ew.ew-btn.ew-m-invisible>.ew.ew-bg{background:var(--background);bottom:0;left:0;opacity:0;position:absolute;right:0;top:0;transition:.15s}.ew.ew-btn.ew-m-invisible:hover>.ew.ew-bg{opacity:1}.ew.ew-field{background:var(--tmspc-background);font-family:var(--tmspc-font-text);padding:8px}.ew.ew-field+.ew.ew-field{border-top:2px solid var(--tmspc-color-tint);margin-top:16px;padding-top:16px}.ew.ew-field-label{color:var(--tmspc-color-base);font-size:16px;font-weight:400;padding-bottom:8px}.ew.ew-field-message{background-color:var(--tmspc-color-tint);border-radius:var(--tmspc-border-radius);color:var(--tmspc-color-light);margin-top:8px;padding:8px}.ew.ew-field-message.ew-m-success{background-color:var(--tmspc-success-tint);color:var(--tmspc-success-base)}.ew.ew-field-message.ew-m-warning{background-color:var(--tmspc-warning-tint);color:var(--tmspc-warning-base)}.ew.ew-field-message.ew-m-danger{background-color:var(--tmspc-danger-tint);color:var(--tmspc-danger-base)}.ew.ew-input{align-items:center;-webkit-appearance:none;-moz-appearance:none;appearance:none;background-color:var(--tmspc-background);border:2px solid var(--tmspc-color-base);border-radius:var(--tmspc-border-radius);box-shadow:none;color:var(--tmspc-color-base);display:flex;font-family:var(--tmspc-font-text);font-size:16px;line-height:1em;min-height:48px;padding:8px 12px;position:relative;width:100%}.ew.ew-input:disabled{background:var(--tmspc-color-tint);border-color:var(--tmspc-color-light)}.ew.ew-input:invalid:not(:focus){border-color:var(--tmspc-warning-base)}.ew.ew-select-wrapper{position:relative}.ew.ew-select::-ms-expand{display:none}.ew.ew-select.ew-is-empty{color:var(--tmspc-color-light)}.ew.ew-select-icon{border:2px solid var(--tmspc-color-base);border-left:none;border-top:none;height:10px;margin-top:-6px;position:absolute;right:20px;top:50%;transform:rotate(45deg);width:10px}.ew.ew-checkbox-input,.ew.ew-radio-buttons--item-input{-webkit-appearance:none;-moz-appearance:none;appearance:none;border:2px solid var(--tmspc-color-base);display:grid;height:20px;place-content:center;width:20px}.ew.ew-checkbox-input:before,.ew.ew-radio-buttons--item-input:before{background-color:var(--color);content:"";display:block;height:12px;transform:scale(0);transition:transform .12s ease-in-out;width:12px}.ew.ew-checkbox-input:hover,.ew.ew-radio-buttons--item-input:hover{opacity:.9}.ew.ew-checkbox-input:active,.ew.ew-radio-buttons--item-input:active{opacity:.75}.ew.ew-checkbox-input:checked:before,.ew.ew-radio-buttons--item-input:checked:before{transform:scale(1)}.ew.ew-checkbox-input:disabled,.ew.ew-radio-buttons--item-input:disabled{background-color:var(--tmspc-color-tint);border-color:var(--tmspc-color-light);pointer-events:none}.ew.ew-checkbox-input:disabled:hover:before,.ew.ew-radio-buttons--item-input:disabled:hover:before{transform:scale(0)}.ew.ew-checkbox.is-disabled .ew-checkbox-input,.ew.ew-radio-buttons.is-disabled .ew-radio-buttons--item-input{border-color:var(--tmspc-color-light)}.ew.ew-checkbox{display:inline-block;padding:8px}.ew.ew-radio-buttons.m-vertical{display:flex;flex-direction:column}.ew.ew-radio-buttons.is-disabled .ew-radio-buttons--item{cursor:default}.ew.ew-radio-buttons.is-disabled .ew-radio-buttons--item-label{color:var(--tmspc-color-light)}.ew.ew-radio-buttons--item{align-items:center;cursor:pointer;display:inline-flex;padding:8px}.ew.ew-radio-buttons--item-input{border-radius:10px}.ew.ew-radio-buttons--item-input:before{border-radius:6px}.ew.ew-radio-buttons--item-label{color:var(--tmspc-color-base);font-family:var(--tmspc-font-text);padding-left:12px}""" ]