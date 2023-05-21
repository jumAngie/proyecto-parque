
export interface AjaxResponse<T> {
	success : boolean,
	errorMessage? : string,
	page?: number,
	pages?: number,
	total?: number,
	result : T
}