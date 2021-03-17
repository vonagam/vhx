package vhx.macro;

import haxe.macro.Expr;

import haxe.macro.PositionTools;


typedef DocOptions = {

  ?doc: Nil< String >,

};

typedef MetaOptions = {

  ?meta: Nil< ToMetadata >,

};

typedef ParamedOptions = {

  ?params: Nil< Array< ToTypeParamDecl > >,

};

typedef FieldOptions = DocOptions & MetaOptions & {

  ?access: Nil< Array< ToAccess > >,

};

typedef PropOptions = FieldOptions & {

  ?defaults: Nil< ToExpr >,

};

typedef FuncOptions = FieldOptions & ParamedOptions & {

  ?body: Nil< ToExpr >,

};

typedef DefinitionOptions = DocOptions & MetaOptions & ParamedOptions & {

  ?isExtern: Nil< Bool >,

};

typedef ClassKindOptions = {

  ?isFinal: Nil< Bool >,

  ?isInterface: Nil< Bool >,

  ?extended: Nil< ToTypePath >,

  ?implemented: Nil< Array< ToTypePath > >,

};

typedef ClassOptions = DefinitionOptions & ClassKindOptions;

typedef AbstractKindOptions = {

  ?from: Nil< Array< ToComplexType > >,

  ?to: Nil< Array< ToComplexType > >,

};

typedef AbstractOptions = DefinitionOptions & AbstractKindOptions;


class ExprTools {

  public static var here = PositionTools.make( { min: 0, max: 0, file: 'unknown' } );


  public static function meta( name: String, ?args: Array< ToExpr > ) {

    final meta: ToMetadataEntry = {

      pos: here,

      name: name,

      params: args,

    };

    return meta;

  }

  public static inline function metas( metadata: ToMetadata ) return metadata;


  public static inline function mConst() return meta( ':const' );

  public static inline function mEnum() return meta( ':enum' );

  public static inline function mExtern() return meta( ':extern' );

  public static inline function mForward() return meta( ':forward' );

  public static inline function mForwardNew() return meta( ':forward.new' );

  public static inline function mForwardStatics() return meta( ':forwardStatics' );

  public static inline function mFrom() return meta( ':from' );

  public static inline function mInclude( path: String ) return meta( ':include', [ eString( path ) ] );

  public static inline function mNative( name: String ) return meta( ':native', [ eString( name ) ] );

  public static inline function mOp( expression: ToExpr ) return meta( ':op', [ expression ] );

  public static inline function mOverload( func: Function ) return meta( ':overload', [ eFunction( func ) ] );

  public static inline function mTransitive() return meta( ':transitive' );

  public static inline function mStructAccess() return meta( ':structAccess' );

  public static inline function mTo() return meta( ':to' );


  public static function expr( definition: ExprDef ) {

    final expr: ToExpr = {

      pos: here,

      expr: definition,

    };

    return expr;

  }

  public static inline function eInt( int: Int ) {

    return expr( EConst( CInt( '$int' ) ) );

  }

  public static inline function eFloat( float: Float ) {

    return expr( EConst( CFloat( '$float' ) ) );

  }

  public static function eString( string: String, singles: Bool = false ) {

    final expr: ToExpr = {

      pos: ( singles ? macro '' : macro "" ).pos,

      expr: EConst( CString( string, singles ? SingleQuotes : DoubleQuotes ) ),

    };

    return expr;

  }

  public static inline function eIdent( ident: String ) {

    return expr( EConst( CIdent( ident ) ) );

  }

  public static inline function eBool( bool: Bool ) {

    return eIdent( '$bool' );

  }

  public static inline function eTrue() {

    return eBool( true );

  }

  public static inline function eFalse() {

    return eBool( false );

  }

  public static inline function eNull() {

    return eIdent( 'null' );

  }

  public static inline function eThis() {

    return eIdent( 'this' );

  }

  public static inline function eSuper() {

    return eIdent( 'super' );

  }

  public static inline function eRegexp( regexp: String, flags: String = '' ) {

    return expr( EConst( CRegexp( regexp, flags ) ) );

  }

  public static inline function eArray( array: ToExpr, index: ToExpr ) {

    return expr( EArray( array, index ) );

  }

  public static inline function eBinop( left: ToExpr, operation: ToBinop, right: ToExpr ) {

    return expr( EBinop( operation, left, right ) );

  }

  public static inline function eField( object: ToExpr, field: String ) {

    return expr( EField( object, field ) );

  }

  public static inline function eParenthesis( expression: ToExpr ) {

    return expr( EParenthesis( expression ) );

  }

  public static function eArrayDecl( ?values: Array< ToExpr > ) {

    return expr( EArrayDecl( or( values, [] ) ) );

  }

  public static function eCall( expression: ToExpr, ?args: Array< ToExpr > ) {

    return expr( ECall( expression, or( args, [] ) ) );

  }

  public static function eNew( type: ToTypePath, ?args: Array< ToExpr > ) {

    return expr( ENew( type, or( args, [] ) ) );

  }

  public static inline function eUnop( operation: ToUnop, expression: ToExpr, right: Bool = false ) {

    return expr( EUnop( operation, right, expression ) );

  }

  public static inline function eFunction( func: Function, ?kind: FunctionKind ) {

    return expr( EFunction( kind, func ) );

  }

  public static inline function eBlock( ?expression: Array< ToExpr > ) {

    return expr( EBlock( or( expression, [] ) ) );

  }

  public static inline function eFor( condition: ToExpr, body: ToExpr ) {

    return expr( EFor( condition, body ) );

  }

  public static inline function eIf( condition: ToExpr, yes: ToExpr, ?no: ToExpr ) {

    return expr( EIf( condition, yes, no ) );

  }

  public static inline function eWhile( condition: ToExpr, body: ToExpr, doing: Bool = false ) {

    return expr( EWhile( condition, body, ! doing ) );

  }

  public static inline function eReturn( ?expression: ToExpr ) {

    return expr( EReturn( expression ) );

  }

  public static inline function eBreak() {

    return expr( EBreak );

  }

  public static inline function eContinue() {

    return expr( EContinue );

  }

	public static inline function eUntyped( expression: ToExpr ) {

    return expr( EUntyped( expression ) );

  }

	public static inline function eThrow( expression: ToExpr ) {

    return expr( EThrow( expression ) );

  }

	public static inline function eCast( expression: ToExpr, ?type: ToComplexType ) {

    return expr( ECast( expression, type ) );

  }

  public static inline function eTernary( condition: ToExpr, yes: ToExpr, no: ToExpr ) {

    return expr( ETernary( condition, yes, no ) );

  }

	public static inline function eCheckType( expression: ToExpr, type: ToComplexType ) {

    return expr( ECheckType( expression, type ) );

  }

	public static inline function eMeta( entry: ToMetadataEntry, expression: ToExpr ) {

    return expr( EMeta( entry, expression ) );

  }


  public static inline function tParam( type: ToComplexType ): ToTypeParam {

    return TPType( type );

  }

  public static inline function teParam( expression: ToExpr ): ToTypeParam {

    return TPExpr( expression );

  }

  public static inline function tparams( params: Array< ToTypeParam > ) {

    return params;

  }


  public static function tyPath( path: String, ?params: Array< ToTypeParam > ) {

    final pack = path.split( '.' );

    final type: ToTypePath = {

      pack: pack,

      name: pack.pop(),

      sub: null,

      params: params,

    };

    if ( pack.length > 0 && ~/^[A-Z]/.match( pack[ pack.length - 1 ] ) ) {

      type.sub = type.name;

      type.name = pack.pop();

    }

    return type;

  }


  public static inline function type( type: ToComplexType ) {

    return type;

  }

  public static inline function tPath( path: String, ?params: Array< ToTypeParam > ) {

    return TPath( tyPath( path, params ) );

  }

  public static inline function tAny() {

    return tPath( 'Any' );

  }

  public static inline function tDynamic() {

    return tPath( 'Dynamic' );

  }

  public static inline function tVoid() {

    return tPath( 'Void' );

  }

  public static inline function tInt() {

    return tPath( 'Int' );

  }

  public static inline function tFloat() {

    return tPath( 'Float' );

  }

  public static inline function tBool() {

    return tPath( 'Bool' );

  }

  public static inline function tString() {

    return tPath( 'String' );

  }

  public static inline function tNull( type: ToComplexType ) {

    return tPath( 'Null', [ tParam( type ) ] );

  }

  public static inline function tArray( type: ToComplexType ) {

    return tPath( 'Array', [ tParam( type ) ] );

  }

  public static inline function tMap( key: ToComplexType, value: ToComplexType ) {

    return tPath( 'Map', [ tParam( key ), tParam( value ) ] );

  }

  public static function tFun( ?args: Array< ToComplexType >, ?type: ToComplexType ) {

    return TFunction( or( args, [] ), or( type, tVoid() ) );

  }

  public static function tAnon( fields: Array< ToField >, ?extended: Array< ToTypePath > ) {

    return extended != null ? TExtend( extended, fields ) : TAnonymous( fields );

  }

  public static inline function tIntersection( types: Array< ToComplexType > ) {

    return TIntersection( types );

  }


  public static function dParam( name: String, ?options: MetaOptions & { ?constraints: Array< ToComplexType > } ) {

    final options = or( options, {} );

    final param: ToTypeParamDecl = {

      meta: options.meta,

      name: name,

      constraints: options.constraints,

    };

    return param;

  }

  public static inline function dParams( params: Array< ToTypeParamDecl > ) {

    return params;

  }


  public static function field( name: String, kind: FieldType, ?options: FieldOptions ) {

    final options = or( options, {} );

    final field: ToField = {

      pos: here,

      doc: options.doc,

      meta: options.meta,

      access: options.access,

      kind: kind,

      name: name,

    };

    return field;

  }

  public static inline function fields( fields: Array< ToField > ) {

    return fields;

  }

  public static function fVar( name: String, ?type: ToComplexType, ?options: PropOptions ) {

    final options = or( options, {} );

    return field( name, FVar( type, options.defaults ), options );

  }

  public static function fProp( name: String, get: String, set: String, ?type: ToComplexType, ?options: PropOptions ) {

    final options = or( options, {} );

    return field( name, FProp( get, set, type, options.defaults ), options );

  }

  public static function fFun( name: String, ?args: Array< ToFunctionArg >, ?type: ToComplexType, ?options: FuncOptions ) {

    final options = or( options, {} );

    return field( name, FFun( {

      params: options.params,

      args: or( args, [] ),

      ret: or( type, tVoid() ),

      expr: options.body,

    } ), options );

  }


  public static function definition( name: String, kind: TypeDefKind, ?fields: Array< ToField >, ?options: DefinitionOptions ) {

    final fields = or( fields, [] );

    final options = or( options, {} );

    final pack = name.split( '.' );

    final definition: ToTypeDefinition = {

      pos: here,

      pack: pack,

      doc: options.doc,

      meta: options.meta,

      isExtern: options.isExtern,

      kind: kind,

      name: pack.pop(),

      params: options.params,

      fields: fields,

    };

    return definition;

  }

  public static inline function tdEnum() {

    return TDEnum;

  }

  public static inline function dEnum( name: String, ?fields: Array< ToField >, ?options: DefinitionOptions ) {

    return definition( name, tdEnum(), fields, options );

  }

  public static inline function tdStructure() {

    return TDStructure;

  }

  public static inline function dStructure( name: String, ?fields: Array< ToField >, ?options: DefinitionOptions ) {

    return definition( name, tdStructure(), fields, options );

  }

  public static inline function tdAlias( type: ToComplexType ) {

    return TDAlias( type );

  }

  public static inline function dAlias( name: String, type: ToComplexType, ?options: DefinitionOptions ) {

    return definition( name, tdAlias( type ), null, options );

  }

  public static function tdClass( ?options: ClassKindOptions ) {

    final options = or( options, {} );

    return TDClass(

      options.extended,

      options.implemented,

      options.isInterface,

      options.isFinal

    );

  }

  public static inline function dClass( name: String, ?fields: Array< ToField >, ?options: ClassOptions ) {

    return definition( name, tdClass( options ), fields, options );

  }

  public static function tdAbstract( ?type: ToComplexType, ?options: AbstractKindOptions ) {

    final options = or( options, {} );

    return TDAbstract(

      type,

      options.from,

      options.to

    );

  }

  public static inline function dAbstract( name: String, ?type: ToComplexType, ?fields: Array< ToField >, ?options: AbstractOptions ) {

    return definition( name, tdAbstract( type, options ), fields, options );

  }


  public static function arg( name: String, ?type: ToComplexType, ?options: MetaOptions & { ?value: ToExpr, ?optional: Bool } ) {

    final options = or( options, {} );

    final arg: ToFunctionArg = {

      meta: options.meta,

      opt: options.optional,

      name: name,

      type: type,

      value: options.value,

    };

    if ( arg.name.charAt( 0 ) == '?' ) {

      arg.name = name.substr( 1 );

      arg.opt = true;

    }

    return arg;

  }

  public static inline function args( args: Array< ToFunctionArg > ) {

    return args;

  }


  public static inline function ge( expression: ToExpr ) {

    return expression;

  }

  public static function geString( expression: ToExpr ) {

    return switch ( expression.expr ) {

      case EConst( CString( string ) ): string;

      case _: throw 'Failed to extract string from expression.';

    };

  }

  public static function geMeta( expression: ToExpr ) {

    return switch ( expression.expr ) {

      case EMeta( meta, _ ): ( meta: ToMetadataEntry );

      case _: throw 'Failed to extract meta from expression.';

    };

  }

  public static function geMetas( expression: ToExpr ) {

    final metas = new Array< ToMetadataEntry >();

    while ( true ) {

      switch ( expression.expr ) {

        case EMeta( meta, next ): metas.push( meta ); expression = next;

        case _: break;

      }

    }

    return metas;

  }

  public static function gtyPath( type: ToComplexType ) {

    return switch ( type ) {

      case TPath( path ): path;

      case _: throw 'Failed to extract type path from type.';

    }

  }

  public static inline function gd( declaration: ToTypeDefinition ) {

    return declaration;

  }

  public static inline function gdFields( declaration: ToTypeDefinition ) {

    return declaration.fields;

  }

  public static inline function gdField( declaration: ToTypeDefinition ) {

    return declaration.fields[ 0 ];

  }

}


@:forward @:transitive

abstract ToMetadataEntry( {

  name: String,

  ?params: Nil< Array< ToExpr > >,

  pos: Position,

} ) from MetadataEntry to MetadataEntry {

  @:from static inline function fromString( value: String ): ToMetadataEntry

    return ExprTools.meta( value );

  @:from static inline function fromParamsStruct( value: { name: String, ?params: Array< ToExpr > } ): ToMetadataEntry

    return ExprTools.meta( value.name, value.params );

  @:from static inline function fromParamStruct( value: { name: String, param: ToExpr } ): ToMetadataEntry

    return ExprTools.meta( value.name, [ value.param ] );

}


typedef ToMetadata = Array< ToMetadataEntry >;


@:forward @:transitive

abstract ToExpr( {

  expr: ExprDef,

  pos: Position,

} ) from Expr to Expr {

  @:from static inline function fromExprDef( value: ExprDef ): ToExpr

    return ExprTools.expr( value );

  @:from static inline function fromString( value: String ): ToExpr

    return ExprTools.eString( value );

  @:from static inline function fromInt( value: Int ): ToExpr

    return ExprTools.eInt( value );

  @:from static inline function fromFloat( value: Float ): ToExpr

    return ExprTools.eFloat( value );

  @:from static inline function fromBool( value: Bool ): ToExpr

    return ExprTools.eBool( value );

  @:from static inline function fromRegexpStruct( value: { regexp: String, ?flags: String } ): ToExpr

    return ExprTools.eRegexp( value.regexp, value.flags );

}


@:forward @:transitive

abstract ToTypeParam( TypeParam ) from TypeParam to TypeParam {

  @:from static inline function fromComplexType( value: ToComplexType ): ToTypeParam

    return TPType( value );

  @:from static inline function fromExpr( value: ToExpr ): ToTypeParam

    return TPExpr( value );

}


@:forward @:transitive

abstract ToTypePath( {

  pack: Array< String >,

  name: String,

  ?params: Nil< Array< ToTypeParam > >,

  ?sub: Nil< String >,

} ) from TypePath to TypePath {

  @:from static inline function fromString( value: String ): ToTypePath

    return ExprTools.tyPath( value );

  @:from static inline function fromStruct( value: { path: String, ?params: Array< ToTypeParam > } ): ToTypePath

    return ExprTools.tyPath( value.path, value.params );

}


@:forward @:transitive

abstract ToComplexType( ComplexType ) from ComplexType to ComplexType {

  @:from static inline function fromString( value: String ): ToComplexType

    return ExprTools.tPath( value );

  @:from static inline function fromTypePath( value: TypePath ): ToComplexType

    return TPath( value );

  @:from static inline function fromPathStruct( value: { path: String, ?params: Array< ToTypeParam > } ): ToComplexType

    return ExprTools.tPath( value.path, value.params );

  @:from static inline function fromFuncStruct( value: { ?args: Array< ToComplexType >, type: ToComplexType } ): ToComplexType

    return ExprTools.tFun( value.args, value.type );

  @:from static inline function fromFields( value: Array< ToField > ): ToComplexType

    return ExprTools.tAnon( value );

  @:from static inline function fromAnonStruct( value: { fields: Array< ToField >, ?extended: Array< ToTypePath > } ): ToComplexType

    return ExprTools.tAnon( value.fields, value.extended );

  @:from static inline function fromComplexTypes( value: Array< ToComplexType > ): ToComplexType

    return ExprTools.tIntersection( value );

}


@:forward @:transitive

abstract ToTypeParamDecl( {

  name: String,

  ?constraints: Nil< Array< ToComplexType > >,

  ?params: Nil< Array< ToTypeParamDecl > >,

	?meta: Nil< ToMetadata >,

} ) from TypeParamDecl to TypeParamDecl {

  @:from static inline function fromString( value: String ): ToTypeParamDecl

    return ExprTools.dParam( value );

}


@:forward @:transitive

abstract ToField( {

  name: String,

  ?doc: Nil< String >,

  ?access: Nil< Array< ToAccess > >,

  kind: FieldType,

  pos: Position,

	?meta: Nil< ToMetadata >,

} ) from Field to Field {

  @:from static inline function fromStruct( value: FieldOptions & { name: String, kind: FieldType } ): ToField

    return ExprTools.field( value.name, value.kind, value );

  @:from static inline function fromPropStruct( value: PropOptions & { name: String, get: String, set: String, ?type: ToComplexType } ): ToField

    return ExprTools.fProp( value.name, value.get, value.set, value.type, value );

  @:from static inline function fromFuncStruct( value: FuncOptions & { name: String, args: Array< ToFunctionArg >, ?type: ToComplexType } ): ToField

    return ExprTools.fFun( value.name, value.args, value.type, value );

  @:from static inline function fromVarStruct( value: PropOptions & { name: String, ?type: ToComplexType } ): ToField

    return ExprTools.fVar( value.name, value.type, value );

}


@:forward @:transitive

abstract ToFunctionArg( {

  var name: String;

	var ?opt: Nil< Bool >;

	var type: Nil< ComplexType >;

	var ?value: Nil< Expr >;

	var ?meta: Nil< ToMetadata >;

} ) from FunctionArg to FunctionArg {

  @:from static inline function fromStruct( value: MetaOptions & { name: String, ?type: ToComplexType, ?value: ToExpr, ?optional: Bool } ): ToFunctionArg

    return ExprTools.arg( value.name, value.type, value );

}


typedef ToTypeDefinition = {

  pack: Array<String>,

  name: String,

  ?doc: Nil< String >,

  pos: Position,

  ?meta: Nil< ToMetadata >,

  ?params: Nil< Array< ToTypeParamDecl > >,

  ?isExtern: Nil< Bool >,

  kind: TypeDefKind,

  fields: Array< ToField >,

}


@:forward @:transitive

abstract ToAccess( Access ) to Access from Access {

  @:from static function fromString( value: String ): ToAccess

    return switch( value ) {

      case 'public': APublic;

      case 'private': APrivate;

      case 'static': AStatic;

      case 'override': AOverride;

      case 'dynamic': ADynamic;

      case 'inline': AInline;

      case 'macro': AMacro;

      case 'final': AFinal;

      case 'extern': AExtern;

      case 'overload': AOverload;

      case _: throw 'Unknown access modifier "$value".';

    }

}


@:forward @:transitive

abstract ToBinop( Binop ) to Binop from Binop {

  @:from static function fromString( value: String ): ToBinop

    return switch( value ) {

      case '+': OpAdd;

      case '*': OpMult;

      case '/': OpDiv;

      case '-': OpSub;

      case '=': OpAssign;

      case '==': OpEq;

      case '!=': OpNotEq;

      case '>': OpGt;

      case '>=': OpGte;

      case '<': OpLt;

      case '<=': OpLte;

      case '&': OpAnd;

      case '|': OpOr;

      case '^': OpXor;

      case '&&': OpBoolAnd;

      case '||': OpBoolOr;

      case '<<': OpShl;

      case '>>': OpShr;

      case '>>>': OpUShr;

      case '%': OpMod;

      case '...': OpInterval;

      case '=>': OpArrow;

      case 'in': OpIn;

      case _ if ( value.substr( -1 ) == '=' ): OpAssignOp( fromString( value.substr( 0, value.length - 1 ) ) );

      case _: throw 'Unknown binary operator "$value".';

    }

  public function toOpExpr()

    return ExprTools.eBinop( ExprTools.eIdent( '_' ), this, ExprTools.eIdent( '_' ) );

}


@:forward @:transitive

abstract ToUnop( Unop ) to Unop from Unop {

  @:from static function fromString( value: String ): ToUnop

    return switch( value ) {

      case '++': OpIncrement;

      case '--': OpDecrement;

      case '!': OpNot;

      case '-': OpNeg;

      case '~': OpNegBits;

      case _: throw 'Unknown unary operator "$value".';

    }

  public function toOpExpr( right: Bool = false )

    return ExprTools.eUnop( this, ExprTools.eIdent( '_' ), right );

}
