package vhx.iter.impl;


class EnumerateIterable< T > {

  final iterable: Iterable< T >;


  public inline function new( iterable: Iterable< T > ) {

    this.iterable = iterable;

  }


  public inline function iterator()

    return new EnumerateIterator( iterable.iterator() );

}


class EnumerateIterator< T > {

  final iterator: Iterator< T >;

  var index: Int;


  public inline function new( iterator: Iterator< T > ) {

    this.iterator = iterator;

    this.index = 0;

  }


  public inline function hasNext()

    return iterator.hasNext();

  public inline function next()

    return { key: index++, value: iterator.next() };

}
