_side = _this;

switch (_side) do {
  case west: {
    if (!(getMarkerColor "opforSafeMarker" isEqualTo "") && !(_side isEqualTo east)) then {
      "opforSafeMarker" setMarkerAlphaLocal 0;
    };
  };
  case east: {
    if (!(getMarkerColor "bluforSafeMarker" isEqualTo "") && !(_side isEqualTo west)) then {
      "bluforSafeMarker" setMarkerAlphaLocal 0;
    };
  };
};

if !(_side isEqualTo startLocationsSide) then {
  _markers = ["optStartMark_1","optStartMark_2","optStartMark_3","optStartMark_4","optStartMark_5","optStart_1","optStart_2","optStart_3","optStart_4","optStart_5"];
  {
    _x setMarkerAlphaLocal 0;
  } forEach _markers;
};
