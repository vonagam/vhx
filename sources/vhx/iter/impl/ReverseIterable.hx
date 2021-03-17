package vhx.iter.impl;


class ReverseIterable< T > {

  final array: Array< T >;


  public inline function new( array: Array< T > ) {

    this.array = array;

  }


  public inline function iterator()

    return new ReverseIterator( array );

}


class ReverseIterator< T > {

  final array: Array< T >;

  var index: Int;


  public inline function new( array: Array< T > ) {

    this.array = array;

    this.index = array.length - 1;

  }


  public inline function hasNext()

    return index != -1;

  public inline function next()

    return array[ index-- ];

}
