function( who , res ){
    res.avg = res.total_weight / res.count;
    return res;
}
