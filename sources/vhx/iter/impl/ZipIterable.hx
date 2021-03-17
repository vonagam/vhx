package vhx.iter.impl;


class ZipIterable< K, V > {

  final firstIterable: Iterable< K >;

  final secondIterable: Iterable< V >;


  public inline function new( firstIterable: Iterable< K >, secondIterable: Iterable< V > ) {

    this.firstIterable = firstIterable;

    this.secondIterable = secondIterable;

  }


  public inline function iterator()

    return new ZipIterator( this.firstIterable.iterator(), this.secondIterable.iterator() );

}


class ZipIterator< K, V > {

  final firstIterator: Iterator< K >;

  final secondIterator: Iterator< V >;


  public inline function new( firstIterator: Iterator< K >, secondIterator: Iterator< V > ) {

    this.firstIterator = firstIterator;

    this.secondIterator = secondIterator;

  }


  public inline function hasNext()

    return firstIterator.hasNext() && secondIterator.hasNext();

  public inline function next()

    return { key: firstIterator.next(), value: secondIterator.next() };

}
