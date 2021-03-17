package vhx.iter.impl;

import vhx.funcs.Predicate;

import vhx.iter.SimpleIterator;


class TakeWhileIterable< T > {

  final iterable: Iterable< T >;

  final predicate: Predicate< T >;


  public inline function new( iterable: Iterable< T >, predicate: Predicate< T > ) {

    this.iterable = iterable;

    this.predicate = predicate;

  }


  public inline function iterator()

    return new TakeWhileIterator( iterable.iterator(), predicate );

}


class TakeWhileIterator< T > extends SimpleIterator< T > {

  final iterator: Iterator< T >;

  final predicate: Predicate< T >;


  public function new( iterator: Iterator< T >, predicate: Predicate< T > ) {

    this.iterator = iterator;

    this.predicate = predicate;

  }


  function step() {

    has = iterator.hasNext();

    if ( ! has ) return;

    value = iterator.next();

    has = predicate( value );

  }

}
