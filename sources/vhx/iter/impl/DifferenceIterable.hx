package vhx.iter.impl;

import vhx.iter.SimpleIterator;


class DifferenceIterable< T > {

  final iterable: Iterable< T >;

  final values: Iterable< T >;


  public inline function new( iterable: Iterable< T >, values: Iterable< T > ) {

    this.iterable = iterable;

    this.values = values;

  }


  public inline function iterator()

    return new DifferenceIterator( iterable.iterator(), values.iterator() );

}


class DifferenceIterator< T > extends SimpleIterator< T > {

  final iterator: Iterator< T >;

  final values: Array< T >;


  public function new( iterator: Iterator< T >, values: Iterator< T > ) {

    this.iterator = iterator;

    this.values = [ for ( value in values ) value ];

  }


  function step() {

    while ( true ) {

      has = iterator.hasNext();

      if ( ! has ) return;

      value = iterator.next();

      if ( ! values.contains( value ) ) return;

    }

  }

}
