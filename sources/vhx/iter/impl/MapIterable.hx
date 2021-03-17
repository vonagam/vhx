package vhx.iter.impl;

import vhx.funcs.Mapper;


class MapIterable< S, T > {

  final iterable: Iterable< S >;

  final map: Mapper< S, T >;


  public inline function new( iterable: Iterable< S >, map: Mapper< S, T > ) {

    this.iterable = iterable;

    this.map = map;

  }


  public inline function iterator()

    return new MapIterator( iterable.iterator(), map );

}


class MapIterator< S, T > {

  final iterator: Iterator< S >;

  final map: Mapper< S, T >;


  public inline function new( iterator: Iterator< S >, map: Mapper< S, T > ) {

    this.iterator = iterator;

    this.map = map;

  }


  public inline function hasNext()

    return iterator.hasNext();

  public inline function next()

    return map( iterator.next() );

}
