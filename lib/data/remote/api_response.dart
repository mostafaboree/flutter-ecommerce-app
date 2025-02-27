sealed class ApiResponse<T> {
  const ApiResponse();
}

class SuccessResponse<T> extends ApiResponse<T> {
  final T data;
   SuccessResponse(this.data);
}




class ErrorResponse<T> extends ApiResponse<T> {
  final String message;

  ErrorResponse(this.message);
}




