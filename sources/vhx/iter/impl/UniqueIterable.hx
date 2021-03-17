package vhx.iter.impl;

import vhx.iter.SimpleIterator;


class UniqueIterable< T > {

  final iterable: Iterable< T >;


  public inline function new( iterable: Iterable< T > )

    this.iterable = iterable;


  public inline function iterator()

    return new UniqueIterator( iterable.iterator() );

}


class UniqueIterator< T > extends SimpleIterator< T > {

  final iterator: Iterator< T >;

  final values = new Array< T >();


  public function new( iterator: Iterator< T > ) {

    this.iterator = iterator;

  }


  function step() {

    while ( true ) {

      has = iterator.hasNext();

      if ( ! has ) return;

      value = iterator.next();

      if ( ! values.contains( value ) ) {

        values.push( value );

        return;

      }

    }

  }

}
