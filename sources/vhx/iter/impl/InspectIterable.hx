package vhx.iter.impl;

import vhx.funcs.Consumer;


class InspectIterable< T > {

  final iterable: Iterable< T >;

  final consume: Consumer< T >;


  public inline function new( iterable: Iterable< T >, consume: Consumer< T > ) {

    this.iterable = iterable;

    this.consume = consume;

  }


  public inline function iterator()

    return new InspectIterator( iterable.iterator(), consume );

}


class InspectIterator< T > {

  final iterator: Iterator< T >;

  final consume: Consumer< T >;


  public inline function new( iterator: Iterator< T >, consume: Consumer< T > ) {

    this.iterator = iterator;

    this.consume = consume;

  }


  public inline function hasNext()

    return iterator.hasNext();

  public inline function next() {

    final value = iterator.next();

    consume( value );

    return value;

  }

}
