print("test")
UUID<-commandArgs(T)[1]


start<-Sys.time()
fit<-try({
	setwd("../r")
	library(rjson)

	source("W_plots.R")
	source("W_process.R")
	userParams<-fromJSON(file=paste0("../jsonCache/userParams_",UUID,".json"))
	jsonpath<-paste0("../jsonCache/res_",UUID,".json")
	result<-list()
	result$UUID<-userParams$UUID
	result$res$outputs<-get(userParams$func)(userParams)
	if(!is.null(result$res$outputs$error)){
		result$res$error<-result$res$outputs$error
	}
	result$func<-userParams$func
})

result$debug$Delay<-paste("Process in R takes",as.numeric(difftime(Sys.time(),start,unit="sec")),"secs.")
if('try-error' %in% class(fit)){
	co<-attr(fit,"condition")
	result$error<-paste0(co[1],"\n\nDetailed error:\n\n",co[2])
	
}



write(toJSON(result),file=jsonpath)
print("done")
