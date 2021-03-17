package vhx.ds;

import haxe.ds.Option as StdOption;

import vhx.nil.Nil;


@:forward @:transitive

@:using( vhx.ds.Option )

abstract Option< T >( StdOption< T > ) from StdOption< T > to StdOption< T > {

  public static inline function isSome< T >( that: Option< T > )

    return that != None;

  public static inline function isNone< T >( that: Option< T > )

    return that == None;


  public static function get< T >( that: Option< T > ): Nil< T >

    return switch ( that ) { case Some( value ): value; case _: null; };

  public static function unwrap< T >( that: Option< T > )

    return switch ( that ) { case Some( value ): value; case _: throw 'Cannot unwrap None.'; };

}
