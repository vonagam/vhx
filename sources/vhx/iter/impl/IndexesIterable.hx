package vhx.iter.impl;


class IndexesIterable< T > {

  final iterable: Iterable< T >;


  public inline function new( iterable: Iterable< T > ) {

    this.iterable = iterable;

  }


  public inline function iterator()

    return new IndexesIterator( iterable.iterator() );

}


class IndexesIterator< T > {

  final iterator: Iterator< T >;

  var index: Int;


  public inline function new( iterator: Iterator< T > ) {

    this.iterator = iterator;

    this.index = 0;

  }


  public inline function hasNext()

    return iterator.hasNext();

  public inline function next()

    return index++;

}
