package vhx.macro;

using haxe.macro.Expr;

using vhx.iter.IterTools;


class MergeTools {

  public static function mergeTypeDefinition( base: TypeDefinition, source: TypeDefinition, ?adding: Bool ) {

    final result: TypeDefinition = {

      pos: base.pos,

      pack: mergeLengthy( base.pack, source.pack ),

      doc: mergeNully( base.doc, source.doc ),

      meta: mergeConcat( base.meta, source.meta ),

      isExtern: mergeBooly( base.isExtern, source.isExtern ),

      kind: mergeTypeDefKind( base.kind, source.kind ),

      name: mergeLengthy( base.name, source.name ),

      params: mergeLengthy( base.params, source.params ),

      fields: mergeFields( base.fields, source.fields, adding ),

    };

    return result;

  }

  public static function mergeTypeDefKind( base: TypeDefKind, source: TypeDefKind ) {

    if ( source.equals( base ) ) return base;

    return switch ( base ) {

      case TDClass( bSuperClass, bInterfaces, bIsInterface, bIsFinal ): switch ( source ) {

        case TDClass( sSuperClass, sInterfaces, sIsInterface, sIsFinal ):

          TDClass(

            mergeNully( bSuperClass, sSuperClass ),

            mergeConcat( bInterfaces, sInterfaces ),

            mergeBooly( bIsInterface, sIsInterface ),

            mergeBooly( bIsFinal, sIsFinal )

          );

      case _: source; }

      case TDAbstract( bThis, bFrom, bTo ): switch ( source ) {

        case TDAbstract( sThis, sFrom, sTo ):

          TDAbstract(

            mergeNully( bThis, sThis ),

            mergeConcat( bFrom, sFrom ),

            mergeConcat( bTo, sTo )

          );

      case _: source; }

      case _: source;

    }

  }

  public static function mergeFields( base: Array< Field >, source: Array< Field >, ?adding: Bool ) {

    final result = base.copy();

    for ( sField in source ) {

      final bField = base.iter().find( field -> field.name == sField.name );

      if ( bField == null ) {

        if ( adding == false ) throw 'Couldnt find field ${ sField.name }.';

        result.push( sField );

      } else {

        if ( adding == true ) throw 'Couldnt add field ${ sField.name }, already exists.';

        result[ result.indexOf( bField ) ] = mergeField( bField, sField );

      }

    }

    return result;

  }

  public static function mergeField( base: Field, source: Field ) {

    final result: Field = {

      pos: base.pos,

      doc: mergeNully( base.doc, source.doc ),

      meta: mergeConcat( base.meta, source.meta ),

      kind: mergeFieldKind( base.kind, source.kind ),

      name: mergeLengthy( base.name, source.name ),

      access: mergeUnique( base.access, source.access ),

    };

    return result;

  }

  public static function mergeFieldKind( base: FieldType, source: FieldType ) {

    if ( source.equals( base ) ) return base;

    return switch ( base ) {

      case FProp( bGet, bSet, bType, bExpression ): switch( source ) {

        case FProp( sGet, sSet, sType, sExpression ):

          mergeFieldPropKind( bType, bExpression, sGet, sSet, sType, sExpression );

        case FVar( sType, sExpression ):

          mergeFieldPropKind( bType, bExpression, bGet, bSet, sType, sExpression );

      case _: source; }

      case FVar( bType, bExpression ): switch( source ) {

        case FVar( sType, sExpression ):

          mergeFieldPropKind( bType, bExpression, 'default', 'default', sType, sExpression );

        case FProp( sGet, sSet, sType, sExpression ):

          mergeFieldPropKind( bType, bExpression, sGet, sSet, sType, sExpression );

      case _: source; }

      case FFun( bFunction ): switch( source ) {

        case FFun( sFunction ):

          FFun( mergeFunction( bFunction, sFunction ) );

      case _: source; }

      case _: source;

    }

  }

  public static function mergeFieldPropKind( bType, bExpression, sGet: String, sSet: String, sType, sExpression ) {

    return if ( sGet == 'default' && sSet == 'default' ) {

      FVar( mergeNully( bType, sType ), mergeNully( bExpression, sExpression ) );

    } else {

      FProp( sGet, sSet, mergeNully( bType, sType ), mergeNully( bExpression, sExpression ) );

    }

  }

  public static function mergeFunction( base: Function, source: Function ) {

    final result: Function = {

      params: mergeLengthy( base.params, source.params ),

      args: mergeLengthy( base.args, source.args ),

      ret: mergeNully( base.ret, source.ret ),

      expr: mergeNully( base.expr, source.expr ),

    };

    return result;

  }

  public static function mergeNully< T >( base: Null< T >, source: Null< T > ) {

    return source != null ? source : base;

  }

  public static function mergeBooly( base: Null< Bool >, source: Null< Bool > ) {

    return source == true ? source : base;

  }

  public static function mergeLengthy< T: { public var length( default, null ): Int; } >( base: Null< T >, source: Null< T > ) {

    return source != null && source.length != 0 ? source : base;

  }

  public static function mergeConcat< T >( base: Null< Array< T > >, source: Null< Array< T > > ) {

    if ( source == null || source.length == 0 ) return base;

    if ( base == null || base.length == 0 ) return source;

    return base.concat( source );

  }

  public static function mergeUnique< T >( base: Null< Array< T > >, source: Null< Array< T > > ) {

    if ( source == null || source.length == 0 ) return base;

    if ( base == null || base.length == 0 ) return source;

    return base.concat( source.filter( value -> ! base.iter().contains( value ) ) );

  }

}
