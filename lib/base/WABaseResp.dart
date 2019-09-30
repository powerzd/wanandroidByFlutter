class WABaseResp<T>{
  String status;
  int errCode;
  String errMsg;
  T data;
  WABaseResp(this.status,this.errCode,this.errMsg,this.data);
}