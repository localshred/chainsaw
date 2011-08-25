function( who , res ){
    res.average = res.total_weight / res.count;
    return res;
}
