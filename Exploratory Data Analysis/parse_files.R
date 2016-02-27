
add_static_column<- function(df, col_name,string){
        df[,col_name]<-rep(string, nrow(df))
        df
}