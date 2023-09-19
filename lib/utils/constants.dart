import 'package:flutter/material.dart';

//----------------------------------------
// MARK: - API
//----------------------------------------

const String apiKey = 'aBBpWBWdHveK5y5w9Cbln7kci0vNiT0g';

const String contentType = 'application/x-www-form-urlencoded';
const String contentTypeForLogout = 'application/xml';
const String cacheControl = 'no-cache';

const int notFound = 404;
const int connectTimeOut = 504;
const int cancelledRequest = 499;
const int badRequest = 400;
const int unAuth = 401;
const int forbidden = 403;
const int unsupportedMediaType = 415;
const int serverError = 500;

const int maxRetryCount = 2;

//----------------------------------------
// MARK: - Keys
//----------------------------------------

const Key appOverlayKeyTitle = Key('AppOverlay_TitleKey');
const Key appOverlayKeyMessage = Key('AppOverlay_MessageKey');
const Key appOverlayKeyOkButton = Key('AppOverlay_ActionOkKey');
const Key appOverlayKeyAlertDialog = Key('AppOverlay_AlertDialog');
const Key appOverlayKeyLoadingIndicator = Key('AppOverlay_LoadingIndicatorKey');
const Key appOverlayKeyLoadingMessage = Key('AppOverlay_LoadingMessageKey');
