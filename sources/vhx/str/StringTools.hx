package vhx.str;

using StringTools;

using vhx.iter.IterTools;

using vhx.str.ERegTools;


class StringTools {

  public static inline function first( value: String )

    return value.length != 0 ? value.charAt( 0 ) : '';

  public static inline function last( value: String )

    return value.length != 0 ? value.charAt( value.length - 1 ) : '';

  public static inline function includes( value: String, string: String, ?fromIndex: Int )

    return value.indexOf( string, fromIndex ) != -1;

  public static inline function remove( value: String, string: String )

    return value.replace( string, '' );

  public static function capitalize( value: String )

    return value.charAt( 0 ).toUpperCase() + value.substr( 1 ).toLowerCase();

  public static function upperFirst( value: String )

    return value.charAt( 0 ).toUpperCase() + value.substr( 1 );


  public static function toCase( value: String, mapper: ( value: String, isFirst: Bool ) -> String, delimiter: String ) {

    var result = '';

    var isFirst = true;

    for ( part in words( value ) ) {

      if ( ! isFirst ) result += delimiter;

      result += mapper( part, isFirst );

      isFirst = false;

    }

    return result;

  }

  public static function toCamelCase( value: String )

    return toCase( value, ( value, isFirst ) -> isFirst ? value.toLowerCase() : capitalize( value ), '' );

  public static function toKebabCase( value: String )

    return toCase( value, ( value, _ ) -> value.toLowerCase(), '-' );

  public static function toLowCase( value: String )

    return toCase( value, ( value, _ ) -> value.toLowerCase(), ' ' );

  public static function toPascalCase( value: String )

    return toCase( value, ( value, _ ) -> capitalize( value ), '' );

  public static function toSnakeCase( value: String )

    return toCase( value, ( value, _ ) -> value.toLowerCase(), '_' );

  public static function toStartCase( value: String )

    return toCase( value, ( value, _ ) -> upperFirst( value ), ' ' );

  public static function toUpCase( value: String )

    return toCase( value, ( value, _ ) -> value.toUpperCase(), ' ' );

  public static function toConstantCase( value: String )

    return toCase( value, ( value, _ ) -> value.toUpperCase(), '_' );


  public static function words( value: String ) {

    if ( value.length == 0 ) return [ '' ];

    final parts = ~/([A-Z]?[a-z]+|[A-Z]+|[0-9]+)/g.forMatched( value ).iter().toArray();

    var index = parts.length;

    while ( --index > 0 ) {

      final next = parts[ index ];

      if ( ! ~/^[a-z]/.match( next ) ) continue;

      final prev = parts[ index - 1 ];

      if ( ! ~/[A-Z]$/.match( prev ) ) continue;

      parts[ index ] = prev.charAt( prev.length - 1 ) + next;

      parts[ index - 1 ] = prev.substr( 0, prev.length - 1 );

      if ( parts[ index - 1 ].length == 0 ) parts.splice( index - 1, 1 );

      --index;

    }

    return parts;

  }


  public static function splitGrouped( value: String, delimiter: String, isClosed: ( substring: String ) -> Bool ) {

    if ( value == '' ) return [];

    final groups = new Array< String >();

    var accumulator = null;

    var closed = true;

    for ( value in value.split( delimiter ) ) {

      closed = isClosed( value );

      if ( accumulator == null ) {

        if ( closed ) {

          groups.push( value );

        } else {

          accumulator = value;

        }

      } else {

        accumulator += delimiter + value;

        if ( closed ) {

          groups.push( accumulator );

          accumulator = null;

        }

      }

    }

    return groups;

  }

  public static function splitDeeplyGrouped( value: String, delimiter: String, getChange: ( substring: String ) -> Int ) {

    var counter = 0;

    final groups = splitGrouped( value, delimiter, function( string ) {

      counter += getChange( string );

      return counter == 0;

    } );

    return groups;

  }

  public static function splitEvenlyGrouped( value: String, delimiter: String, getChange: ( substring: String ) -> Int ) {

    var counter = 0;

    final groups = splitGrouped( value, delimiter, function( string ) {

      counter += getChange( string );

      return counter % 2 == 0;

    } );

    return groups;

  }


  public static function countChar( value: String, char: String ) {

    var count = 0;

    for ( index in 0...value.length ) if ( value.charAt( index ) == char ) ++count;

    return count;

  }

  public static function countChars( value: String, chars: Array< String > ) {

    var count = 0;

    for ( index in 0...value.length ) if ( chars.indexOf( value.charAt( index ) ) != -1 ) ++count;

    return count;

  }

  public static function countString( value: String, string: String ) {

    var count = 0;

    var index = 0;

    while ( ( index = value.indexOf( string, index ) + 1 ) != 0 ) ++count;

    return count;

  }


  public static inline function hasPrefix( value: String, prefix: String )

    return value.startsWith( prefix );

  public static inline function hasSuffix( value: String, suffix: String )

    return value.endsWith( suffix );

  public static function removePrefix( value: String, prefix: String )

    return value.startsWith( prefix ) ? value.substr( prefix.length ) : value;

  public static function removeSuffix( value: String, suffix: String )

    return value.endsWith( suffix ) ? value.substr( 0, -suffix.length ) : value;

  public static function replacePrefix( value: String, prefix: String, replacement: String )

    return value.startsWith( prefix ) ? replacement + value.substr( prefix.length ) : value;

  public static function replaceSuffix( value: String, suffix: String, replacement: String )

    return value.endsWith( suffix ) ? value.substr( 0, -suffix.length ) + replacement : value;

}
