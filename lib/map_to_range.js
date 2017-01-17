function mapToRange ( num, inputMin, inputMax, outputMin, outputMax ) {
	// thanks SO: http://stackoverflow.com/questions/929103/convert-a-number-range-to-another-range-maintaining-ratio
	var inputRange = inputMax - inputMin;
	var outputRange = outputMax - outputMin;

	if( inputRange === 0 ) throw 'Input range = 0';
	if( outputRange === 0 ) throw 'Ouput range = 0';
	if( num < inputMin || num > inputMax ) throw new RangeError( 'Num is outside of input range.' );

	return ( ( ( num - inputMin ) * outputRange ) / inputRange ) + outputMin ;
}
