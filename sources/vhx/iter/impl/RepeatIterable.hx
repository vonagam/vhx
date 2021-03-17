package vhx.iter.impl;


class RepeatIterable< T > {

  final value: T;


  public inline function new( value: T ) {

    this.value = value;

  }


  public inline function iterator()

    return new RepeatIterator( value );

}


class RepeatIterator< T > {

  final value: T;


  public inline function new( value: T ) {

    this.value = value;

  }


  public inline function hasNext()

    return true;

  public inline function next()

    return value;

}
