	function Vector2D (x, y) {
		this.x = x || 0;
		this.y = y || 0;
	}

	Vector2D.prototype = {
		constructor: Vector2D,

		add: function add (v2) {
			this.x += v2.x;
			this.y += v2.y;

			return this;
		},

		div: function div (divisor) {
			if( divisor === 0 ) throw 'Division by zero causes problems. Don\'t do it.';
			this.x /= divisor;
			this.y /= divisor;

			return this;
		},

		limit: function limit ( max ) {
			if( this.mag() > max ) this.normalise().mult( max );
			return this;
		},

		mag: function mag () {
			var x_squared = Math.pow( this.x, 2 );
			var y_squared = Math.pow( this.y, 2 );

			return Math.sqrt( x_squared + y_squared );
		},

		mult: function mult (multiplier) {
			this.x *= multiplier;
			this.y *= multiplier;

			return this;
		},

		normalise: function normalise () {
			if( this.mag() === 0 ) throw "Cannot normalise a vector of magnitude 0.";
			return this.div( this.mag() );
		},

		set: function set (arg1, y) {
			if( arg1 instanceof Vector2D ) {
				this.x = arg1.x;
				this.y = arg1.y;
			} else {
				if( typeof arg1 !== 'number' || typeof y !== 'number' ) {
					throw 'Must supply eithr a Vector2D or two numbers';
				}

				this.x = arg1 || 0;
				this.y = y || 0;
			}

			return this;
		},

		sub: function sub (v2) {
			this.x -= v2.x;
			this.y -= v2.y;

			return this;
		}
	}

	Vector2D.sum = function sum (v1, v2) {
		return new Vector2D(
			v1.x + v2.x,
			v1.y + v2.y
		);
	}

	Vector2D.diff = function diff (v1, v2) {
		return new Vector2D(
			v1.x - v2.x,
			v1.y - v2.y
		);
	}

	Vector2D.scale = function scale (factor, multiplier) {
		return new Vector2D(
			factor.x * multiplier,
			factor.y * multiplier
		);
	}

	Vector2D.quotient = function quotient (dividend, divisor) {
		return new Vector2D(
			dividend.x / divisor,
			dividend.y / divisor
		);
	}
