package vhx.nil;

import vhx.funcs.Block;

import vhx.funcs.Consumer;

import vhx.funcs.Mapper;

import vhx.funcs.Predicate;

import vhx.funcs.Supplier;


@:using( vhx.nil.Nil )

@:using( vhx.nil.NilArrayTools )

@:using( vhx.nil.NilMapTools )

@:using( vhx.nil.NilIterableTools )

@:using( vhx.nil.NilKeyValueIterableTools )

@:using( vhx.nil.NilStringTools )

@:transitive

abstract Nil< T >( Null< T > ) from Null< T > to Null< T > {

  public var value( get, never ): Null< T >;

  public var isSet( get, never ): Bool;

  public var isNull( get, never ): Bool;


  public static inline function nil< T >( ?value: Nil< T > ): Nil< T >

    return value;


  extern inline function get_value()

    return this;

  extern inline function get_isSet()

    return this != null;

  extern inline function get_isNull()

    return this == null;


  @:op( _! ) public static inline function sure< T >( that: Nil< T > ): T

    return @:nullSafety( Off ) ( that: T );

  @:noImportGlobal public static inline function unwrap< T >( that: Nil< T > ): T

    return that != null ? that : throw 'Cannot get T from null.';


  public static inline function ifSet< T >( that: Nil< T >, func: Consumer< T > )

    if ( that != null ) func( that );

  public static inline function ifNull< T >( that: Nil< T >, func: Block )

    if ( that == null ) func();

  @:noImportGlobal public static inline function ifElse< T >( that: Nil< T >, setFunc: Consumer< T >, nullFunc: Block )

    if ( that != null ) setFunc( that ); else nullFunc();


  public static inline function or< T >( that: Nil< T >, value: Supplier< T > ): T

    return that != null ? that : value();

  @:noImportGlobal public static inline function orMaybe< T >( that: Nil< T >, value: Supplier< Nil< T > > ): Nil< T >

    return that != null ? that : value();


  @:noImportGlobal public static inline function map< T, R >( that: Nil< T >, value: Mapper< T, Nil< R > > ): Nil< R >

    return that != null ? value( that ) : null;

  @:noImportGlobal public static inline function invert< T, R >( that: Nil< T >, value: Supplier< Nil< R > > ): Nil< R >

    return that != null ? null : value();

  @:noImportGlobal public static inline function turn< T, R >( that: Nil< T >, setValue: Mapper< T, R >, nullValue: Supplier< R > )

    return that != null ? setValue( that ) : nullValue();


  @:noImportGlobal public static inline function filter< T >( that: Nil< T >, predicate: Predicate< T > ): Nil< T >

    return that != null && predicate( that ) ? that : null;

  @:noImportGlobal public static inline function reject< T >( that: Nil< T >, predicate: Predicate< T > ): Nil< T >

    return that != null && ! predicate( that ) ? that : null;


  public static inline function isTrue< T >( that: Nil< T >, predicate: Predicate< T > )

    return that != null && predicate( that );

  public static inline function isFalse< T >( that: Nil< T >, predicate: Predicate< T > )

    return that != null && ! predicate( that );

  public static inline function isntTrue< T >( that: Nil< T >, predicate: Predicate< T > )

    return that == null || ! predicate( that );

  public static inline function isntFalse< T >( that: Nil< T >, predicate: Predicate< T > )

    return that == null || predicate( that );

}
