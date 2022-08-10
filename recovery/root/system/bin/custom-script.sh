#!/system/bin/sh

FP_ID=$(cat /proc/fp_id)

# setprop *boot* property because we dont like resetting it
# ro.build.product overrides to support non-unified custom ROMs
# ro.product.product.device overrides to support realme ui 1 flash

if grep -q androidboot.prjname /proc/cmdline; then
    echo "custom-script: Detected realme UI 2 firmware" > /tmp/recovery.log
    resetprop ro.device.latest_fw true
else
    echo "custom-script: Detected realme UI 1 firmware" > /tmp/recovery.log
    resetprop ro.device.latest_fw false
fi

if grep -q SDM710 /proc/cpuinfo && [ $FP_ID = F_1511 ]; then
  setprop ro.boot.prjname 18621
  resetprop ro.build.product RMX1851
elif grep -q SDM712 /proc/cpuinfo && [ $FP_ID = F_1511 ]; then
  setprop ro.boot.prjname 19691
  resetprop ro.build.product RMX1971
fi

if grep -q 19651 /proc/cmdline; then
  setprop ro.boot.prjname 19651
  resetprop ro.build.product RMX1921
elif grep -q 18041 /proc/cmdline && [ $FP_ID = G_OPTICAL_G2 ] ; then
  setprop ro.boot.prjname 19605
  resetprop ro.build.product RMX1901
fi

resetprop ro.product.product.device $(getprop ro.build.product)
