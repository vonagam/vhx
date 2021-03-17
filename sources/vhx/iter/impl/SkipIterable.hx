package vhx.iter.impl;


class SkipIterable< T > {

  final iterable: Iterable< T >;

  final length: Int;


  public inline function new( iterable: Iterable< T >, length: Int ) {

    this.iterable = iterable;

    this.length = length;

  }


  public inline function iterator()

    return new SkipIterator( iterable.iterator(), length );

}


class SkipIterator< T > {

  final iterator: Iterator< T >;

  var length: Int;


  public function new( iterator: Iterator< T >, length: Int ) {

    this.iterator = iterator;

    this.length = length;

  }


  public function hasNext() {

    while ( length-- > 0 ) {

      if ( ! iterator.hasNext() ) return false;

      iterator.next();

    }

    return iterator.hasNext();

  }

  public function next()

    return iterator.next();

}
