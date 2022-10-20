module W.Styles exposing (baseTheme, globalStyles)

{-|

@docs globalStyles

-}

import Html as H
import Theme


{-| -}
baseTheme : H.Html msg
baseTheme =
    Theme.globalProvider Theme.lightTheme


{-| -}
globalStyles : H.Html msg
globalStyles =
    H.node "style"
        []
        [ H.text """*,:after,:before{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgba(59,130,246,.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: }::backdrop{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgba(59,130,246,.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: }.ew-btn{align-items:center;box-sizing:border-box;display:inline-flex;font-family:var(--theme-font-text);font-weight:600;justify-content:center;letter-spacing:.05em;line-height:1;padding-bottom:0;padding-top:0;text-decoration-line:none}.ew-btn-like{-webkit-appearance:none;-moz-appearance:none;appearance:none;border-radius:.5rem;border-width:0;box-sizing:border-box;text-decoration-line:none}.ew-check-radio{--tw-bg-opacity:1;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-ring-color:rgb(var(--theme-primary-fg-ch)/0.5);--tw-ring-offset-width:0px;align-items:center;-webkit-appearance:none;-moz-appearance:none;appearance:none;background-color:rgb(var(--theme-base-bg-ch)/var(--tw-bg-opacity));border-color:rgb(var(--theme-base-aux-ch)/.3);border-style:solid;border-width:2px;box-shadow:var(--tw-ring-offset-shadow,0 0 #0000),var(--tw-ring-shadow,0 0 #0000),var(--tw-shadow);display:inline-flex;height:1.75rem;justify-content:center;margin:0;outline-width:0;width:1.75rem}.ew-check-radio,.ew-check-radio:before{transition-duration:.15s;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,-webkit-backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter,-webkit-backdrop-filter;transition-timing-function:cubic-bezier(.4,0,.2,1)}.ew-check-radio:before{--tw-content:"";--tw-scale-x:0;--tw-scale-y:0;background-color:currentColor;content:var(--tw-content);display:block;height:1rem;transform:translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));transition-timing-function:cubic-bezier(0,0,.2,1);width:1rem}.ew-check-radio:hover{opacity:.9}.ew-check-radio:active{opacity:.75}.ew-check-radio:checked{--tw-bg-opacity:1}.ew-check-radio:checked,.ew-check-radio:focus{background-color:rgb(var(--theme-base-bg-ch)/var(--tw-bg-opacity))}.ew-check-radio:focus{--tw-border-opacity:1;--tw-bg-opacity:1;--tw-ring-offset-shadow:var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);--tw-ring-shadow:var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);border-color:rgb(var(--theme-primary-fg-ch)/var(--tw-border-opacity));box-shadow:var(--tw-ring-offset-shadow),var(--tw-ring-shadow),var(--tw-shadow,0 0 #0000)}.ew-check-radio:checked:before{--tw-scale-x:1;--tw-scale-y:1;content:var(--tw-content);transform:translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y))}.ew-check-radio:disabled{background-color:rgb(var(--theme-base-aux-ch)/.25)}.ew-pointer-events-none{pointer-events:none}.ew-fixed{position:fixed}.ew-absolute{position:absolute}.ew-relative{position:relative}.ew-sticky{position:sticky}.ew-inset-0{left:0;right:0}.ew-inset-0,.ew-inset-y-0{bottom:0;top:0}.ew-inset-x-\\[12px\\]{left:12px;right:12px}.ew-inset-x-0{left:0;right:0}.ew-inset-y-1{bottom:.25rem;top:.25rem}.ew-bottom-full{bottom:100%}.ew-left-full{left:100%}.ew-top-1\\/2{top:50%}.ew-left-0{left:0}.-ew-top-px{top:-1px}.ew-top-0{top:0}.ew-right-1{right:.25rem}.ew-z-0{z-index:0}.ew-z-\\[9999\\]{z-index:9999}.ew-z-10{z-index:10}.ew-m-0{margin:0}.-ew-mx-px{margin-left:-1px;margin-right:-1px}.-ew-mb-2\\.5{margin-bottom:-.625rem}.-ew-ml-2\\.5{margin-left:-.625rem}.-ew-mb-2{margin-bottom:-.5rem}.-ew-ml-2{margin-left:-.5rem}.ew-mt-2{margin-top:.5rem}.-ew-mt-0\\.5{margin-top:-.125rem}.-ew-mt-0{margin-top:0}.-ew-mt-\\[3px\\]{margin-top:-3px}.-ew-ml-5{margin-left:-1.25rem}.-ew-mt-5{margin-top:-1.25rem}.ew-mb-1{margin-bottom:.25rem}.ew-box-border{box-sizing:border-box}.ew-block{display:block}.ew-inline-block{display:inline-block}.ew-flex{display:flex}.ew-inline-flex{display:inline-flex}.ew-table{display:table}.ew-grid{display:grid}.ew-hidden{display:none}.ew-h-\\[32px\\]{height:32px}.ew-h-\\[40px\\]{height:40px}.ew-h-\\[48px\\]{height:48px}.ew-h-1{height:.25rem}.ew-h-\\[6px\\]{height:6px}.ew-h-10{height:2.5rem}.ew-h-9{height:2.25rem}.ew-h-7{height:1.75rem}.ew-h-1\\.5{height:.375rem}.ew-h-0{height:0}.ew-max-h-\\[80\\%\\]{max-height:80%}.ew-min-h-\\[48px\\]{min-height:48px}.ew-w-full{width:100%}.ew-w-\\[40\\%\\]{width:40%}.ew-w-\\[60\\%\\]{width:60%}.ew-w-10{width:2.5rem}.ew-w-8{width:2rem}.ew-w-1\\.5{width:.375rem}.ew-w-1{width:.25rem}.ew-w-0{width:0}.ew-min-w-\\[32px\\]{min-width:32px}.ew-min-w-\\[40px\\]{min-width:40px}.ew-min-w-\\[48px\\]{min-width:48px}.ew-min-w-full{min-width:100%}.ew-max-w-md{max-width:28rem}.ew-shrink-0{flex-shrink:0}.ew-grow{flex-grow:1}.ew-translate-y-0\\.5{--tw-translate-y:0.125rem}.ew-translate-y-0,.ew-translate-y-0\\.5{transform:translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y))}.ew-translate-y-0{--tw-translate-y:0px}.ew-rotate-\\[45deg\\]{--tw-rotate:45deg}.ew-rotate-\\[45deg\\],.ew-scale-0{transform:translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y))}.ew-scale-0{--tw-scale-x:0;--tw-scale-y:0}@keyframes ew-fade-slide{0%{opacity:0;transform:translateY(10px) scale(.9)}to{opacity:1;transform:translateY(0) scale(1)}}.ew-animate-fade-slide{animation:ew-fade-slide .4s ease-out}.ew-list-none{list-style-type:none}.ew-appearance-none{-webkit-appearance:none;-moz-appearance:none;appearance:none}.ew-flex-col{flex-direction:column}.ew-content-start{align-content:flex-start}.ew-items-start{align-items:flex-start}.ew-items-center{align-items:center}.ew-items-stretch{align-items:stretch}.ew-justify-end{justify-content:flex-end}.ew-justify-center{justify-content:center}.ew-justify-between{justify-content:space-between}.ew-gap-1\\.5{gap:.375rem}.ew-gap-1{gap:.25rem}.ew-gap-6{gap:1.5rem}.ew-gap-4{gap:1rem}.ew-space-x-2>:not([hidden])~:not([hidden]){--tw-space-x-reverse:0;margin-left:calc(.5rem*(1 - var(--tw-space-x-reverse)));margin-right:calc(.5rem*var(--tw-space-x-reverse))}.ew-self-stretch{align-self:stretch}.ew-overflow-auto{overflow:auto}.ew-overflow-hidden{overflow:hidden}.ew-whitespace-pre-wrap{white-space:pre-wrap}.ew-break-words{overflow-wrap:break-word}.ew-rounded-full{border-radius:9999px}.ew-rounded-xl{border-radius:.75rem}.ew-rounded-lg{border-radius:.5rem}.ew-rounded-\\[20px\\]{border-radius:20px}.ew-rounded-\\[16px\\]{border-radius:16px}.ew-rounded{border-radius:.25rem}.ew-border{border-width:1px}.ew-border-0{border-width:0}.ew-border-\\[3px\\]{border-width:3px}.ew-border-2{border-width:2px}.ew-border-t-2{border-top-width:2px}.ew-border-l-2{border-left-width:2px}.ew-border-l-\\[6px\\]{border-left-width:6px}.ew-border-b{border-bottom-width:1px}.ew-border-solid{border-style:solid}.ew-border-base-bg{--tw-border-opacity:1;border-color:rgb(var(--theme-base-bg-ch)/var(--tw-border-opacity))}.ew-border-primary-fg{--tw-border-opacity:1;border-color:rgb(var(--theme-primary-fg-ch)/var(--tw-border-opacity))}.ew-border-neutral-fg{--tw-border-opacity:1;border-color:rgb(var(--theme-neutral-fg-ch)/var(--tw-border-opacity))}.ew-border-base-aux\\/20{border-color:rgb(var(--theme-base-aux-ch)/.2)}.ew-border-current{border-color:currentColor}.ew-border-base-aux\\/10{border-color:rgb(var(--theme-base-aux-ch)/.1)}.ew-border-base-aux\\/30{border-color:rgb(var(--theme-base-aux-ch)/.3)}.ew-border-base-aux{--tw-border-opacity:1;border-color:rgb(var(--theme-base-aux-ch)/var(--tw-border-opacity))}.ew-bg-transparent{background-color:transparent}.ew-bg-primary-bg{--tw-bg-opacity:1;background-color:rgb(var(--theme-primary-bg-ch)/var(--tw-bg-opacity))}.ew-bg-neutral-bg{--tw-bg-opacity:1;background-color:rgb(var(--theme-neutral-bg-ch)/var(--tw-bg-opacity))}.ew-bg-base-bg{--tw-bg-opacity:1;background-color:rgb(var(--theme-base-bg-ch)/var(--tw-bg-opacity))}.ew-bg-danger-fg\\/10{background-color:rgb(var(--theme-danger-fg-ch)/.1)}.ew-bg-warning-fg\\/10{background-color:rgb(var(--theme-warning-fg-ch)/.1)}.ew-bg-success-fg\\/10{background-color:rgb(var(--theme-success-fg-ch)/.1)}.ew-bg-base-aux\\/10{background-color:rgb(var(--theme-base-aux-ch)/.1)}.ew-bg-base-aux\\/30{background-color:rgb(var(--theme-base-aux-ch)/.3)}.ew-bg-current{background-color:currentColor}.ew-bg-primary-fg\\/10{background-color:rgb(var(--theme-primary-fg-ch)/.1)}.ew-bg-base-aux\\/\\[0\\.07\\]{background-color:rgb(var(--theme-base-aux-ch)/.07)}.ew-bg-primary-fg{--tw-bg-opacity:1;background-color:rgb(var(--theme-primary-fg-ch)/var(--tw-bg-opacity))}.ew-bg-base-aux{--tw-bg-opacity:1;background-color:rgb(var(--theme-base-aux-ch)/var(--tw-bg-opacity))}.ew-p-2{padding:.5rem}.ew-p-4{padding:1rem}.ew-p-3{padding:.75rem}.ew-p-0{padding:0}.ew-p-6{padding:1.5rem}.ew-px-2\\.5{padding-left:.625rem;padding-right:.625rem}.ew-py-1{padding-bottom:.25rem;padding-top:.25rem}.ew-px-2{padding-left:.5rem;padding-right:.5rem}.ew-px-3{padding-left:.75rem;padding-right:.75rem}.ew-px-5{padding-left:1.25rem;padding-right:1.25rem}.ew-px-6{padding-left:1.5rem;padding-right:1.5rem}.ew-px-1{padding-left:.25rem;padding-right:.25rem}.ew-py-0{padding-bottom:0;padding-top:0}.ew-px-4{padding-left:1rem;padding-right:1rem}.ew-py-2{padding-bottom:.5rem;padding-top:.5rem}.ew-py-4{padding-bottom:1rem;padding-top:1rem}.ew-pl-0{padding-left:0}.ew-pb-1{padding-bottom:.25rem}.ew-pt-0\\.5{padding-top:.125rem}.ew-pt-0{padding-top:0}.ew-pl-2{padding-left:.5rem}.ew-pr-4{padding-right:1rem}.ew-pt-1{padding-top:.25rem}.ew-pb-2{padding-bottom:.5rem}.ew-pb-0{padding-bottom:0}.ew-pr-10{padding-right:2.5rem}.ew-pl-3{padding-left:.75rem}.ew-pt-\\[10px\\]{padding-top:10px}.ew-pt-6{padding-top:1.5rem}.ew-pr-3{padding-right:.75rem}.ew-pr-6{padding-right:1.5rem}.ew-text-left{text-align:left}.ew-font-text{font-family:var(--theme-font-text)}.ew-text-sm{font-size:.875rem;line-height:1.25rem}.ew-text-base{font-size:1rem;line-height:1.5rem}.ew-text-xs{font-size:.75rem;line-height:1rem}.ew-font-semibold{font-weight:600}.ew-font-medium{font-weight:500}.ew-font-normal{font-weight:400}.ew-font-bold{font-weight:700}.ew-uppercase{text-transform:uppercase}.ew-leading-none{line-height:1}.ew-tracking-wider{letter-spacing:.05em}.ew-text-primary-aux{--tw-text-opacity:1;color:rgb(var(--theme-primary-aux-ch)/var(--tw-text-opacity))}.ew-text-neutral-aux{--tw-text-opacity:1;color:rgb(var(--theme-neutral-aux-ch)/var(--tw-text-opacity))}.ew-text-primary-fg{--tw-text-opacity:1;color:rgb(var(--theme-primary-fg-ch)/var(--tw-text-opacity))}.ew-text-neutral-fg{--tw-text-opacity:1;color:rgb(var(--theme-neutral-fg-ch)/var(--tw-text-opacity))}.ew-text-base-fg{--tw-text-opacity:1;color:rgb(var(--theme-base-fg-ch)/var(--tw-text-opacity))}.ew-text-base-aux{--tw-text-opacity:1;color:rgb(var(--theme-base-aux-ch)/var(--tw-text-opacity))}.ew-text-danger-fg{--tw-text-opacity:1;color:rgb(var(--theme-danger-fg-ch)/var(--tw-text-opacity))}.ew-text-warning-fg{--tw-text-opacity:1;color:rgb(var(--theme-warning-fg-ch)/var(--tw-text-opacity))}.ew-text-success-fg{--tw-text-opacity:1;color:rgb(var(--theme-success-fg-ch)/var(--tw-text-opacity))}.ew-text-transparent{color:transparent}.ew-no-underline{text-decoration-line:none}.ew-opacity-\\[0\\.55\\]{opacity:.55}.ew-opacity-20{opacity:.2}.ew-opacity-0{opacity:0}.ew-shadow-none{--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000}.ew-shadow-lg,.ew-shadow-none{box-shadow:var(--tw-ring-offset-shadow,0 0 #0000),var(--tw-ring-shadow,0 0 #0000),var(--tw-shadow)}.ew-shadow-lg{--tw-shadow:0 10px 15px -3px rgba(0,0,0,.1),0 4px 6px -4px rgba(0,0,0,.1);--tw-shadow-colored:0 10px 15px -3px var(--tw-shadow-color),0 4px 6px -4px var(--tw-shadow-color)}.ew-shadow{--tw-shadow:0 1px 3px 0 rgba(0,0,0,.1),0 1px 2px -1px rgba(0,0,0,.1);--tw-shadow-colored:0 1px 3px 0 var(--tw-shadow-color),0 1px 2px -1px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow,0 0 #0000),var(--tw-ring-shadow,0 0 #0000),var(--tw-shadow)}.ew-outline-0{outline-width:0}.ew-ring-primary-fg\\/50{--tw-ring-color:rgb(var(--theme-primary-fg-ch)/0.5)}.ew-ring-primary-fg{--tw-ring-opacity:1;--tw-ring-color:rgb(var(--theme-primary-fg-ch)/var(--tw-ring-opacity))}.ew-ring-offset-0{--tw-ring-offset-width:0px}.ew-transition-transform{transition-duration:.15s;transition-property:transform;transition-timing-function:cubic-bezier(.4,0,.2,1)}.ew-transition{transition-duration:.15s;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,-webkit-backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter,-webkit-backdrop-filter;transition-timing-function:cubic-bezier(.4,0,.2,1)}.ew-focusable{--tw-ring-color:rgb(var(--theme-primary-fg-ch)/0.5);--tw-ring-offset-width:0px;outline-width:0;transition-duration:.15s;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,-webkit-backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter,-webkit-backdrop-filter;transition-timing-function:cubic-bezier(.4,0,.2,1)}.ew-focusable:focus{--tw-border-opacity:1;--tw-ring-offset-shadow:var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);--tw-ring-shadow:var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);border-color:rgb(var(--theme-primary-fg-ch)/var(--tw-border-opacity));box-shadow:var(--tw-ring-offset-shadow),var(--tw-ring-shadow),var(--tw-shadow,0 0 #0000)}.ew-focusable-outline{--tw-ring-color:rgb(var(--theme-primary-fg-ch)/0.5);--tw-ring-offset-width:0px;outline-width:0;transition-duration:.15s;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,-webkit-backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter;transition-property:color,background-color,border-color,text-decoration-color,fill,stroke,opacity,box-shadow,transform,filter,backdrop-filter,-webkit-backdrop-filter;transition-timing-function:cubic-bezier(.4,0,.2,1)}.ew-focusable-outline:focus{--tw-ring-offset-shadow:var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);--tw-ring-shadow:var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);box-shadow:var(--tw-ring-offset-shadow),var(--tw-ring-shadow),var(--tw-shadow,0 0 #0000)}.ew-select::-ms-expand{display:none}.ew-input::-webkit-calendar-picker-indicator,.ew-input::-webkit-time-picker-indicator{background-image:none;opacity:0}.ew-slider::-webkit-slider-thumb{-webkit-appearance:none;appearance:none;background:currentColor;border-radius:50%;height:24px;width:24px}.ew-slider::-moz-range-thumb{-moz-appearance:none;appearance:none;background:currentColor;border-radius:50%;height:24px;width:24px}.ew-tooltip:after{border-color:var(--theme-neutral-bg) transparent transparent transparent;border-style:solid;border-width:4px 4px 0;content:"";display:block;left:50%;margin-left:-2px;position:absolute;top:100%}.ew-table{border-collapse:collapse;min-width:100%;text-indent:0}.ew-table table,.ew-table tbody,.ew-table td,.ew-table th,.ew-table thead,.ew-table tr{border:0;border-collapse:collapse;margin:0;padding:0}.ew-table tbody tr{border-top:1px solid rgb(var(--theme-base-aux-ch)/.4)}.ew-table td,.ew-table th{padding:8px}.ew-table td:first-child,.ew-table th:first-child{padding-left:16px}.ew-table td:last-child,.ew-table th:last-child{padding-right:16px}.ew-table .ew-table-th-hidden th{padding:0}.ew-table table{table-layout:fixed}.ew-loading-dots{display:inline-block;height:var(--size);position:relative;width:var(--size)}.ew-loading-dots div{animation-timing-function:cubic-bezier(0,1,1,0);background:var(--color);border-radius:calc(var(--size)*.2);height:calc(var(--size)*.2);position:absolute;top:calc(var(--size)*.4);width:calc(var(--size)*.2)}.ew-loading-dots>div:first-child{animation:ew-loading-dots-1 .6s infinite;left:0}.ew-loading-dots>div:nth-child(2){animation:ew-loading-dots-2 .6s infinite;left:0}.ew-loading-dots>div:nth-child(3){animation:ew-loading-dots-2 .6s infinite;left:calc(var(--size)*.4)}.ew-loading-dots>div:nth-child(4){animation:ew-loading-dots-3 .6s infinite;left:calc(var(--size)*.8)}@keyframes ew-loading-dots-1{0%{transform:scale(0)}to{transform:scale(1)}}@keyframes ew-loading-dots-2{0%{transform:translate(0)}to{transform:translate(calc(var(--size)*.4))}}@keyframes ew-loading-dots-3{0%{transform:scale(1)}to{transform:scale(0)}}.ew-loading-ripples{display:inline-block;height:var(--size);position:relative;width:var(--size)}.ew-loading-ripples>div{animation:ew-loading-ripples 1.2s cubic-bezier(0,.2,.8,1) infinite;border:calc(var(--size)*.06) solid var(--color);border-radius:50%;opacity:1;position:absolute}.ew-loading-ripples>div:nth-child(2){animation-delay:-.6s}@keyframes ew-loading-ripples{0%{height:0;left:calc(var(--size)*.5);opacity:1;top:calc(var(--size)*.5);width:0}to{height:var(--size);left:0;opacity:0;top:0;width:var(--size)}}.before\\:ew-absolute:before{content:var(--tw-content);position:absolute}.before\\:ew-inset-0:before{bottom:0;content:var(--tw-content);left:0;right:0;top:0}.before\\:ew-block:before{content:var(--tw-content);display:block}.before\\:ew-h-0\\.5:before{content:var(--tw-content);height:.125rem}.before\\:ew-h-0:before{content:var(--tw-content);height:0}.before\\:ew-w-0\\.5:before{content:var(--tw-content);width:.125rem}.before\\:ew-w-0:before{content:var(--tw-content);width:0}.before\\:ew-grow:before{content:var(--tw-content);flex-grow:1}.before\\:ew-rounded-xl:before{border-radius:.75rem;content:var(--tw-content)}.before\\:ew-rounded-lg:before{border-radius:.5rem;content:var(--tw-content)}.before\\:ew-rounded-\\[24px\\]:before{border-radius:24px;content:var(--tw-content)}.before\\:ew-rounded-\\[20px\\]:before{border-radius:20px;content:var(--tw-content)}.before\\:ew-rounded-\\[16px\\]:before{border-radius:16px;content:var(--tw-content)}.before\\:ew-rounded-sm:before{border-radius:.125rem;content:var(--tw-content)}.before\\:ew-rounded-full:before{border-radius:9999px;content:var(--tw-content)}.before\\:ew-rounded-r:before{border-bottom-right-radius:.25rem;border-top-right-radius:.25rem;content:var(--tw-content)}.before\\:ew-bg-current:before{background-color:currentColor;content:var(--tw-content)}.before\\:ew-bg-base-aux\\/20:before{background-color:rgb(var(--theme-base-aux-ch)/.2);content:var(--tw-content)}.before\\:ew-bg-base-fg\\/\\[0\\.07\\]:before{background-color:rgb(var(--theme-base-fg-ch)/.07);content:var(--tw-content)}.before\\:ew-opacity-0:before{content:var(--tw-content);opacity:0}.before\\:ew-opacity-10:before{content:var(--tw-content);opacity:.1}.before\\:ew-transition-opacity:before{content:var(--tw-content);transition-duration:.15s;transition-property:opacity;transition-timing-function:cubic-bezier(.4,0,.2,1)}.before\\:ew-content-\\[\\'\\'\\]:before{--tw-content:"";content:var(--tw-content)}.after\\:ew-block:after{content:var(--tw-content);display:block}.after\\:ew-h-0\\.5:after{content:var(--tw-content);height:.125rem}.after\\:ew-h-0:after{content:var(--tw-content);height:0}.after\\:ew-w-0\\.5:after{content:var(--tw-content);width:.125rem}.after\\:ew-w-0:after{content:var(--tw-content);width:0}.after\\:ew-grow:after{content:var(--tw-content);flex-grow:1}.after\\:ew-bg-base-aux\\/20:after{background-color:rgb(var(--theme-base-aux-ch)/.2);content:var(--tw-content)}.after\\:ew-content-\\[\\'\\'\\]:after{--tw-content:"";content:var(--tw-content)}.first\\:ew-ml-0:first-child{margin-left:0}.first\\:ew-rounded-l-lg:first-child{border-bottom-left-radius:.5rem;border-top-left-radius:.5rem}.first\\:ew-rounded-l-\\[16px\\]:first-child{border-bottom-left-radius:16px;border-top-left-radius:16px}.first\\:ew-rounded-l-\\[20px\\]:first-child{border-bottom-left-radius:20px;border-top-left-radius:20px}.last\\:ew-mr-0:last-child{margin-right:0}.last\\:ew-rounded-r-lg:last-child{border-bottom-right-radius:.5rem;border-top-right-radius:.5rem}.last\\:ew-rounded-r-\\[16px\\]:last-child{border-bottom-right-radius:16px;border-top-right-radius:16px}.last\\:ew-rounded-r-\\[20px\\]:last-child{border-bottom-right-radius:20px;border-top-right-radius:20px}.hover\\:ew-block:hover{display:block}.hover\\:ew-bg-base-aux\\/\\[0\\.07\\]:hover{background-color:rgb(var(--theme-base-aux-ch)/.07)}.hover\\:ew-bg-primary-fg\\/\\[0\\.15\\]:hover{background-color:rgb(var(--theme-primary-fg-ch)/.15)}.hover\\:ew-opacity-\\[0\\.15\\]:hover{opacity:.15}.hover\\:before\\:ew-opacity-\\[0\\.15\\]:hover:before{content:var(--tw-content);opacity:.15}.hover\\:before\\:ew-opacity-\\[0\\.05\\]:hover:before{content:var(--tw-content);opacity:.05}.focus\\:ew-relative:focus{position:relative}.focus\\:ew-border-primary-fg:focus{--tw-border-opacity:1;border-color:rgb(var(--theme-primary-fg-ch)/var(--tw-border-opacity))}.focus\\:ew-bg-base-bg:focus{--tw-bg-opacity:1;background-color:rgb(var(--theme-base-bg-ch)/var(--tw-bg-opacity))}.focus\\:ew-outline-0:focus{outline-width:0}.focus\\:ew-ring:focus{--tw-ring-offset-shadow:var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);--tw-ring-shadow:var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);box-shadow:var(--tw-ring-offset-shadow),var(--tw-ring-shadow),var(--tw-shadow,0 0 #0000)}.read-only\\:focus\\:ew-bg-base-aux\\/10:focus:-moz-read-only{background-color:rgb(var(--theme-base-aux-ch)/.1)}.read-only\\:focus\\:ew-bg-base-aux\\/10:focus:read-only{background-color:rgb(var(--theme-base-aux-ch)/.1)}.active\\:ew-bg-base-aux\\/10:active{background-color:rgb(var(--theme-base-aux-ch)/.1)}.active\\:ew-bg-primary-fg\\/20:active{background-color:rgb(var(--theme-primary-fg-ch)/.2)}.disabled\\:ew-border-base-aux\\/\\[0\\.25\\]:disabled{border-color:rgb(var(--theme-base-aux-ch)/.25)}.disabled\\:ew-bg-base-aux\\/\\[0\\.25\\]:disabled{background-color:rgb(var(--theme-base-aux-ch)/.25)}.ew-group:focus-within .group-focus-within\\:ew-block{display:block}.ew-group:focus-within .group-focus-within\\:ew-scale-100{--tw-scale-x:1;--tw-scale-y:1;transform:translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y))}.ew-group:hover .group-hover\\:ew-translate-y-0{--tw-translate-y:0px;transform:translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y))}.ew-group:hover .group-hover\\:ew-bg-base-aux\\/\\[0\\.07\\]{background-color:rgb(var(--theme-base-aux-ch)/.07)}.ew-group:hover .group-hover\\:ew-delay-500{transition-delay:.5s}.ew-group:hover .group-hover\\:ew-delay-1000{transition-delay:1s}""" ]