package vhx.str;

import vhx.funcs.Mapper;

import vhx.iter.SimpleIterator;

using vhx.iter.IterTools;


class ERegTools {

  public static inline function matcheds( ereg: EReg, groups: Iterable< Int > )

    return [ for ( group in groups ) ereg.matched( group ) ];


  public static inline function get< T >( ereg: EReg, string: String, resolve: Mapper< EReg, T > ): Nil< T >

    return ereg.match( string ) ? resolve( ereg ) : null;

  public static inline function getMatch( ereg: EReg, string: String )

    return get( ereg, string, ( ereg ) -> ereg );

  public static inline function getMatched( ereg: EReg, string: String, group: Int = 0 )

    return get( ereg, string, ( ereg ) -> ereg.matched( group ) );

  public static inline function getMatcheds( ereg: EReg, string: String, groups: Iterable< Int > )

    return get( ereg, string, ( ereg ) -> matcheds( ereg, groups ) );

  public static inline function getPos( ereg: EReg, string: String )

    return get( ereg, string, ( ereg ) -> ereg.matchedPos() );


  public static inline function forMatch( ereg: EReg, string: String ): Iterable< EReg >

    return { iterator: () -> new ERegIterator( ereg, string, ( ereg ) -> ereg ) };

  public static inline function forMatched( ereg: EReg, string: String, group: Int = 0 ): Iterable< String >

    return { iterator: () -> new ERegIterator( ereg, string, ( ereg ) -> ereg.matched( group ) ) };

  public static inline function forMatcheds( ereg: EReg, string: String, groups: Iterable< Int > ): Iterable< Array< String > >

    return { iterator: () -> new ERegIterator( ereg, string, ( ereg ) -> matcheds( ereg, groups ) ) };

  public static inline function forPos( ereg: EReg, string: String ): Iterable< { pos: Int, len: Int } >

    return { iterator: () -> new ERegIterator( ereg, string, ( ereg ) -> ereg.matchedPos() ) };


  public static inline function count( ereg: EReg, string: String )

    return forMatch( ereg, string ).iter().count();

  public static inline function remove( ereg: EReg, string: String )

    return ereg.replace( string, '' );

}


class ERegIterator< T > extends SimpleIterator< T > {

  final ereg: EReg;

  final resolver: ( ereg: EReg ) -> T;

  var remainder: String;


  public function new( ereg: EReg, string: String, resolver: ( ereg: EReg ) -> T ) {

    this.ereg = ereg;

    this.resolver = resolver;

    this.remainder = string;

  }


  function step() {

    has = ereg.match( remainder );

    remainder = has ? ereg.matchedRight() : '';

    if ( has ) value = resolver( ereg );

  }

}
