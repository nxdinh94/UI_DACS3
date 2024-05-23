// 192.168.1.5 -> IPv4 address in your computer
const String PORT = "http://192.168.1.7:4000";

const String getCashFlowApi = '$PORT/app/get-cash-flow';
const String getCashFlowCateApi = '$PORT/app/get-cash-flow-category';
const String getAccountWalletTypeApi = '$PORT/app/get-money-account-type';
const String getAllAccountWalletApi = '$PORT/app/get-money-account';
const String getExpenseRecordForChartApi = '$PORT/app/expense-record-for-statistics';
const String getMeApi = '$PORT/users/me';


const String postAddingAccountMoney = '$PORT/app/add-money-account';
const String postExpenseRecord      = '$PORT/app/add-expense-record';


const String updateAccountMoney = '$PORT/app/update-money-account';
const String updateMeApi = '$PORT/users/update-me';


const String deleteAccountMoneyApi =  '$PORT/app/delete-money-account';

