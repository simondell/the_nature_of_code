var Frames = ( function () {
	var context = null;

	var running = false;
	var setupCallback = null;
	var drawCallback = null;

	var mouse = {
		x: null,
		y: null,
		pressed: false
	}


	//
	// event handlers
	//
	function setMouseXY ( event ) {
		mouse.x = event.pageX;
		mouse.y = event.pageY;
	}

	function setMousePressedTrue ( event ) {
		mouse.pressed = true;
	}

	function setMousePressedFalse ( event ) {
		mouse.pressed = false;
	}


	//
	// canvas functions
	//
	function setupCanvas(width, height) {
		var canvas = document.createElement( 'canvas' );

		context = canvas.getContext( '2d' );

		canvas.width = width || window.innerWidth;
		canvas.height = height || window.innerHeight;
		document.body.appendChild( canvas );

		canvas.addEventListener( 'mouseenter', setMouseXY );
		canvas.addEventListener( 'mousemove', setMouseXY );
		canvas.addEventListener( 'mousedown', setMousePressedTrue );
		canvas.addEventListener( 'mouseup', setMousePressedFalse );

		return context;
	}


	function clearCanvas () {
			context.clearRect( 0, 0, context.canvas.width, context.canvas.height );
	}


	//
	// animation functions
	//
	function setup ( cb ) {
		setupCallback = cb;

		try {
			setupCallback();
			isSetUp = true;
		} catch ( err ) {
			console.error( 'Failed to setup drawing context' );
			console.error( err );
		}
	}


	function drawLoop () {
		if( running ) {
			drawCallback();
			requestAnimationFrame( drawLoop );
		}
	}


	function go ( setupCB, drawCB ) {
		setup( setupCB );

		drawCallback = drawCB;
		running = true;

		requestAnimationFrame( drawLoop );
	}


	function stop () {
		running = false;
	}




	//
	// Public API
	//
	return {
		go: go,
		stop: stop,
		setupCanvas: setupCanvas,
		clearCanvas: clearCanvas,
		mouse: mouse
	};
})();