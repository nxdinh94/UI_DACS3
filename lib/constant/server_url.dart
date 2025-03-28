// 192.168.1.5 -> IPv4 address in your computer
const String PORT = "http://192.168.2.11:4000";
// const String PORT = "https://financialmanagement.onrender.com";

const String getCashFlowApi                 = '$PORT/app/get-cash-flow';
const String getCashFlowCateApi             = '$PORT/app/get-cash-flow-category';
const String getAccountWalletTypeApi        = '$PORT/app/get-money-account-type';
const String getAllAccountWalletApi         = '$PORT/app/get-money-account';
const String getExpenseRecordForChartApi    = '$PORT/app/expense-record-for-statistics';
const String getMeApi                       = '$PORT/users/me';
const String getRepeatTimeSpendingLimitApi     = '$PORT/admins/repeat-spending-limit';
const String getAllSpendingLimitApi     = '$PORT/app/spending-limit';

const String postAddingAccountMoney = '$PORT/app/add-money-account';
const String postExpenseRecord      = '$PORT/app/add-expense-record';
const String postSpendingLimitApi   = '$PORT/app/add-spending-limit';
const String changePasswordApi      ='$PORT/users/change-password';


const String updateAccountMoney     = '$PORT/app/update-money-account';
const String updateMeApi            = '$PORT/users/update-me';
const String updateExpenseRecordApi = '$PORT/app/update-expense-record';
const String updateSpendingLimitApi    = '$PORT/app/update-spending-limit';




