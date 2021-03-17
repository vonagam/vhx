package vhx.iter;

import vhx.iter.KeyValue;


@:forward @:transitive

abstract Entry< K, V >( KeyValue< K, V > ) from KeyValue< K, V > to KeyValue< K, V > {

  public var k( get, set ): K;

  public var v( get, set ): V;

  public var index( get, set ): K;

  public var i( get, set ): K;

  public var val( get, set ): V;

  public var first( get, set ): K;

  public var second( get, set ): V;


  public inline function new( key: K, value: V ): Entry< K, V >

    this = { key: key, value: value };


  extern inline function get_k() return this.key;

  extern inline function set_k( k: K ) return this.key = k;


  extern inline function get_v() return this.value;

  extern inline function set_v( v: V ) return this.value = v;


  extern inline function get_index() return this.key;

  extern inline function set_index( index: K ) return this.key = index;


  extern inline function get_i() return this.key;

  extern inline function set_i( i: K ) return this.key = i;


  extern inline function get_val() return this.value;

  extern inline function set_val( val: V ) return this.value = val;


  extern inline function get_first() return this.key;

  extern inline function set_first( first: K ) return this.key = first;


  extern inline function get_second() return this.value;

  extern inline function set_second( second: V ) return this.value = second;

}
