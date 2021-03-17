package vhx.iter.impl;


class TakeIterable< T > {

  final iterable: Iterable< T >;

  final length: Int;


  public inline function new( iterable: Iterable< T >, length: Int ) {

    this.iterable = iterable;

    this.length = length;

  }


  public inline function iterator()

    return new TakeIterator( iterable.iterator(), length );

}


class TakeIterator< T > {

  final iterator: Iterator< T >;

  var length: Int;


  public inline function new( iterator: Iterator< T >, length: Int ) {

    this.iterator = iterator;

    this.length = length;

  }


  public inline function hasNext()

    return length > 0 && iterator.hasNext();

  public inline function next() {

    length--;

    return iterator.next();

  }

}
