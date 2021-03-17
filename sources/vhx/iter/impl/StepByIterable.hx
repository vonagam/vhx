package vhx.iter.impl;

import vhx.funcs.Predicate;

import vhx.iter.SimpleIterator;


class StepByIterable< T > {

  final iterable: Iterable< T >;

  final length: Int;


  public inline function new( iterable: Iterable< T >, length: Int ) {

    this.iterable = iterable;

    this.length = length;

  }


  public inline function iterator()

    return new StepByIterator( iterable.iterator(), length );

}


class StepByIterator< T > extends SimpleIterator< T > {

  final iterator: Iterator< T >;

  final length: Int;


  public function new( iterator: Iterator< T >, length: Int ) {

    this.iterator = iterator;

    this.length = length;

  }


  function step() {

    var i = length;

    do {

      has = iterator.hasNext();

      if ( ! has ) return;

      value = iterator.next();

    } while ( --i > 0 );

  }

}
