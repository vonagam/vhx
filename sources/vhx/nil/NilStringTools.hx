package vhx.nil;


class NilStringTools {

  public static inline function orEmpty( that: Nil< String > )

    return that.or( '' );

  public static inline function isEmpty( that: Nil< String > )

    return that.turn( _ -> _.length == 0, true );


  public static inline function charAt( that: Nil< String >, index: Int )

    return that.turn( _ -> _.charAt( index ), '' );

  public static inline function charCodeAt( that: Nil< String >, index: Int )

    return that.turn( _ -> _.charCodeAt( index ), null );

  public static inline function indexOf( that: Nil< String >, string: String, ?startIndex: Int )

    return that.turn( _ -> _.indexOf( string, startIndex ), -1 );

  public static inline function lastIndexOf( that: Nil< String >, string: String, ?startIndex: Int )

    return that.turn( _ -> _.lastIndexOf( string, startIndex ), -1 );

  public static inline function substr( that: Nil< String >, position: Int, ?length: Int )

    return that.turn( _ -> _.substr( position, length ), '' );

  public static inline function substring( that: Nil< String >, startIndex: Int, ?endIndex: Int )

    return that.turn( _ -> _.substring( startIndex, endIndex ), '' );

  public static inline function toLowerCase( that: Nil< String > )

    return that.map( _ -> _.toLowerCase() );

  public static inline function toString( that: Nil< String > )

    return that.map( _ -> _.toString() );

  public static inline function toUpperCase( that: Nil< String > )

    return that.map( _ -> _.toUpperCase() );


  public static inline function length( that: Nil< String > )

    return that.turn( _ -> _.length, 0 );

}
