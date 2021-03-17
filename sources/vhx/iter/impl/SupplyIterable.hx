package vhx.iter.impl;

import vhx.funcs.Supplier;


class SupplyIterable< T > {

  final supplier: Supplier< T >;


  public inline function new( supplier: Supplier< T > ) {

    this.supplier = supplier;

  }


  public inline function iterator()

    return new SupplyIterator( supplier );

}


class SupplyIterator< T > {

  final supplier: Supplier< T >;


  public inline function new( supplier: Supplier< T > ) {

    this.supplier = supplier;

  }


  public inline function hasNext()

    return true;

  public inline function next()

    return supplier();

}
