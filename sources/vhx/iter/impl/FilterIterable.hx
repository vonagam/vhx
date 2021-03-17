package vhx.iter.impl;

import vhx.funcs.Predicate;

import vhx.iter.SimpleIterator;


class FilterIterable< T > {

  final iterable: Iterable< T >;

  final predicate: Predicate< T >;


  public inline function new( iterable: Iterable< T >, predicate: Predicate< T > ) {

    this.iterable = iterable;

    this.predicate = predicate;

  }


  public inline function iterator()

    return new FilterIterator( iterable.iterator(), predicate );

}


class FilterIterator< T > extends SimpleIterator< T > {

  final iterator: Iterator< T >;

  final predicate: Predicate< T >;


  public function new( iterator: Iterator< T >, predicate: Predicate< T > ) {

    this.iterator = iterator;

    this.predicate = predicate;

  }


  function step() {

    while ( true ) {

      has = iterator.hasNext();

      if ( ! has ) return;

      value = iterator.next();

      if ( predicate( value ) ) return;

    }

  }

}
