



/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import '../../export.dart';

enum TrimType {
  Length,
  Line,
}

class ReadMoreTextWidget extends StatefulWidget {
  const ReadMoreTextWidget(
    this.data, {
    Key? key,
    this.preDataText,
    this.postDataText,
    this.preDataTextStyle,
    this.postDataTextStyle,
    this.trimExpandedText = "Read Less",
    this.trimCollapsedText = "Read More",
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimType.Length,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.semanticsLabel,
    this.moreStyle,
    this.lessStyle,
    this.delimiter = '$_kEllipsis ',
    this.delimiterStyle,
    this.callback,
  }) : super(key: key);

  /// Used on TrimMode.Length
  final int trimLength;

  /// Used on TrimMode.Lines
  final int trimLines;

  /// Determines the type of trim. TrimMode.Length takes into account
  /// the number of letters, while TrimMode.Lines takes into account
  /// the number of lines
  final TrimType trimMode;

  /// TextStyle for expanded text
  final TextStyle? moreStyle;

  /// TextStyle for compressed text
  final TextStyle? lessStyle;

  /// Textspan used before the data any heading or somthing
  final String? preDataText;

  /// Textspan used after the data end or before the more/less
  final String? postDataText;

  /// Textspan used before the data any heading or somthing
  final TextStyle? preDataTextStyle;

  /// Textspan used after the data end or before the more/less
  final TextStyle? postDataTextStyle;

  ///Called when state change between expanded/compress
  final Function(bool val)? callback;

  final String delimiter;
  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color? colorClickableText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final double? textScaleFactor;
  final String? semanticsLabel;
  final TextStyle? delimiterStyle;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreTextWidget> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() {
      _readMore = !_readMore;
      widget.callback?.call(_readMore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale = widget.locale ?? Localizations.maybeLocaleOf(context);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).colorScheme.secondary;
    final defaultLessStyle = widget.lessStyle ??
        effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultMoreStyle = widget.moreStyle ??
        effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultDelimiterStyle = widget.delimiterStyle ?? effectiveTextStyle;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText.tr : widget.trimExpandedText.tr,
      style: _readMore ? defaultMoreStyle : defaultLessStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: _readMore
          ? widget.trimCollapsedText.isNotEmpty
              ? widget.delimiter
              : ''
          : '',
      style: defaultDelimiterStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        TextSpan? preTextSpan;
        TextSpan? postTextSpan;
        if (widget.preDataText != null) {
          preTextSpan = TextSpan(
            text: "${widget.preDataText!} ",
            style: widget.preDataTextStyle ?? effectiveTextStyle,
          );
        }
        if (widget.postDataText != null) {
          postTextSpan = TextSpan(
            text: " ${widget.postDataText!}",
            style: widget.postDataTextStyle ?? effectiveTextStyle,
          );
        }

        // Create a TextSpan with data
        final text = TextSpan(
          children: [
            if (preTextSpan != null) preTextSpan,
            TextSpan( text: widget.data, style: effectiveTextStyle),
            if (postTextSpan != null) postTextSpan
          ],
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? widget.delimiter : null,
          locale: locale,
        );
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(Offset(
            textDirection == TextDirection.rtl
                ? readMoreSize
                : textSize.width - readMoreSize,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        TextSpan textSpan;
        switch (widget.trimMode) {
          case TrimType.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                 text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[delimiter, link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
               text:  widget.data,
              );
            }
            break;
          case TrimType.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
             text:    _readMore
                    ? widget.data.substring(0, endIndex) +
                        (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[delimiter, link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return Text.rich(
          TextSpan(
            children: [
              if (preTextSpan != null) preTextSpan,
              textSpan,
              if (postTextSpan != null) postTextSpan,
            ],
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          overflow: TextOverflow.clip,
          textScaleFactor: textScaleFactor,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}
