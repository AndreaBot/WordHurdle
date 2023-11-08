
// class
/**
 * 
 */
 extension anychart.core.ui {
    public class LabelsFactory: anychart.core.Text {

        //override init() {
        //    super.init()
        //}

        public override init() {
            super.init()
            //return LabelsFactory(jsBase: "new anychart.core.ui.LabelsFactory()")
            //super.init(jsBase: "new anychart.core.ui.LabelsFactory()")
        }

        

        public override init(jsBase: String) {
            super.init()

            JsObject.variableIndex += 1
            self.jsBase = "labelsFactory\(JsObject.variableIndex)"
            APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + " = " + jsBase + ";")
        }

        override public func instantiate() -> anychart.core.ui.LabelsFactory {
            return anychart.core.ui.LabelsFactory(jsBase: "new anychart.core.ui.labelsfactory()")
        }

        override public func getJsBase() -> String {
            return jsBase;
        }

        
    /**
     * Getter for the adjust font size.
     */
    public func adjustFontSize()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".adjustFontSize();")
    }
    /**
     * Setter for the adjusting font size by two parameters width and height.
     */
    public func adjustFontSize(adjustByWidth: Bool, adjustByHeight: Bool) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).adjustFontSize(\(adjustByWidth), \(adjustByHeight));")

        return self
    }
    /**
     * Setter for the adjusting font size by one parameter.
     */
    public func adjustFontSize(settings: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).adjustFontSize(\(JsObject.wrapQuotes(value: settings)));")

        return self
    }
    /**
     * Setter for the adjusting font size by one parameter.
     */
    public func adjustFontSize(settings: [Bool]) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).adjustFontSize(\(JsObject.arrayToString(jsObjects: settings)));")

        return self
    }
    /**
     * Setter for the adjusting font size by one parameter.
     */
    public func adjustFontSize(settings: Bool) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).adjustFontSize(\(settings));")

        return self
    }
    /**
     * Getter for the labels anchor settings.
     */
    public func anchor()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".anchor();")
    }
    /**
     * Setter for the labels anchor settings.
     */
    public func anchor(anchor: anychart.enums.Anchor) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).anchor(\((anchor != nil) ? anchor.getJsBase() : "null"));")

        return self
    }
    /**
     * Setter for the labels anchor settings.
     */
    public func anchor(anchor: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).anchor(\(JsObject.wrapQuotes(value: anchor)));")

        return self
    }
    /**
     * Getter for the labels background settings.
     */
    public func background() -> anychart.core.ui.Background {
        return anychart.core.ui.Background(jsBase: self.jsBase + ".background()")
    }
    /**
     * Setter for the labels background settings.
     */
    public func background(settings: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).background(\(JsObject.wrapQuotes(value: settings)));")

        return self
    }
    /**
     * Setter for the labels background settings.
     */
    public func background(settings: Bool) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).background(\(settings));")

        return self
    }
    /**
     * Getter for connector stroke settings.
     */
    public func connectorStroke()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".connectorStroke();")
    }
    /**
     * Getter for connector stroke settings.
     */
    public func connectorStroke(color: Stroke, thickness: Double, dashpattern: String, lineJoin: anychart.graphics.vector.StrokeLineJoin, lineCap: anychart.graphics.vector.StrokeLineCap) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).connectorStroke(\((color != nil) ? color.getJsBase() : "null"), \(thickness), \(JsObject.wrapQuotes(value: dashpattern)), \((lineJoin != nil) ? lineJoin.getJsBase() : "null"), \((lineCap != nil) ? lineCap.getJsBase() : "null"));")

        return self
    }
    /**
     * Getter for connector stroke settings.
     */
    public func connectorStroke(color: String, thickness: Double, dashpattern: String, lineJoin: anychart.graphics.vector.StrokeLineJoin, lineCap: anychart.graphics.vector.StrokeLineCap) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).connectorStroke(\(JsObject.wrapQuotes(value: color)), \(thickness), \(JsObject.wrapQuotes(value: dashpattern)), \((lineJoin != nil) ? lineJoin.getJsBase() : "null"), \((lineCap != nil) ? lineCap.getJsBase() : "null"));")

        return self
    }
    /**
     * Setter for connector stroke using an object.
     */
    public func connectorStroke(settings: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).connectorStroke(\(JsObject.wrapQuotes(value: settings)));")

        return self
    }
    /**
     * Getter for the labels text formatter.
     */
    public func format()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".format();")
    }
    /**
     * Setter for the labels text formatter.<br/>
{docs:Common_Settings/Text_Formatters}Learn more about using the format() method.{docs}
     */
    public func format(token: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).format(\(JsObject.wrapQuotes(value: token)));")

        return self
    }
    /**
     * Returns label by index.
     */
    public func getLabel(index: Double) -> anychart.core.ui.labelsfactory.Label {
        return anychart.core.ui.labelsfactory.Label(jsBase: "\(self.jsBase).getLabel(\(index))")
    }
    /**
     * Gets labels count.
     */
    public func getLabelsCount()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".getLabelsCount();")
    }
    /**
     * Getter for labels height settings.
     */
    public func height()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".height();")
    }
    /**
     * Setter for labels height settings.
     */
    public func height(height: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).height(\(height));")

        return self
    }
    /**
     * Setter for labels height settings.
     */
    public func height(height: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).height(\(JsObject.wrapQuotes(value: height)));")

        return self
    }
    /**
     * Getter for maximum font size settings for adjust text to.
     */
    public func maxFontSize()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".maxFontSize();")
    }
    /**
     * Setter for maximum font size settings for adjust text to.
     */
    public func maxFontSize(size: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).maxFontSize(\(size));")

        return self
    }
    /**
     * Setter for maximum font size settings for adjust text to.
     */
    public func maxFontSize(size: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).maxFontSize(\(JsObject.wrapQuotes(value: size)));")

        return self
    }
    /**
     * Getter for minimum font size settings for adjust text from.
     */
    public func minFontSize()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".minFontSize();")
    }
    /**
     * Setter for the minimum font size settings for adjust text from.
     */
    public func minFontSize(size: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).minFontSize(\(size));")

        return self
    }
    /**
     * Setter for the minimum font size settings for adjust text from.
     */
    public func minFontSize(size: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).minFontSize(\(JsObject.wrapQuotes(value: size)));")

        return self
    }
    /**
     * Getter for the labels offsetX settings.
     */
    public func offsetX()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".offsetX();")
    }
    /**
     * Setter for the labels offsetX settings.
     */
    public func offsetX(offset: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).offsetX(\(offset));")

        return self
    }
    /**
     * Setter for the labels offsetX settings.
     */
    public func offsetX(offset: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).offsetX(\(JsObject.wrapQuotes(value: offset)));")

        return self
    }
    /**
     * Getter for the labels offsetY settings.
     */
    public func offsetY()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".offsetY();")
    }
    /**
     * Setter for the labels offsetY settings.
     */
    public func offsetY(offset: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).offsetY(\(offset));")

        return self
    }
    /**
     * Setter for the labels offsetY settings.
     */
    public func offsetY(offset: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).offsetY(\(JsObject.wrapQuotes(value: offset)));")

        return self
    }
    /**
     * Getter for labels padding settings.
     */
    public func padding() -> anychart.core.utils.Padding {
        return anychart.core.utils.Padding(jsBase: self.jsBase + ".padding()")
    }
    /**
     * Setter for labels padding in pixels using a single value.
     */
    public func padding(padding: [Double]) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(padding.map{String($0)}.joined(separator: ",")));")

        return self
    }
    /**
     * Setter for labels padding in pixels using a single value.
     */
    public func padding(padding: [String]) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.arrayToStringWrapQuotes(array: padding)));")

        return self
    }
    /**
     * Setter for labels padding in pixels using a single value.
     */
    public func padding(padding: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: padding)));")

        return self
    }
    /**
     * Setter for labels padding in pixels using a single value.
     */
    public func padding(padding: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(padding));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: String, value3: String, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(JsObject.wrapQuotes(value: value2)), \(JsObject.wrapQuotes(value: value3)), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: String, value3: String, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(JsObject.wrapQuotes(value: value2)), \(JsObject.wrapQuotes(value: value3)), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: String, value3: Double, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(JsObject.wrapQuotes(value: value2)), \(value3), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: String, value3: Double, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(JsObject.wrapQuotes(value: value2)), \(value3), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: Double, value3: String, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(value2), \(JsObject.wrapQuotes(value: value3)), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: Double, value3: String, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(value2), \(JsObject.wrapQuotes(value: value3)), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: Double, value3: Double, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(value2), \(value3), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: String, value2: Double, value3: Double, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(JsObject.wrapQuotes(value: value1)), \(value2), \(value3), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: String, value3: String, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(JsObject.wrapQuotes(value: value2)), \(JsObject.wrapQuotes(value: value3)), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: String, value3: String, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(JsObject.wrapQuotes(value: value2)), \(JsObject.wrapQuotes(value: value3)), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: String, value3: Double, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(JsObject.wrapQuotes(value: value2)), \(value3), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: String, value3: Double, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(JsObject.wrapQuotes(value: value2)), \(value3), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: Double, value3: String, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(value2), \(JsObject.wrapQuotes(value: value3)), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: Double, value3: String, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(value2), \(JsObject.wrapQuotes(value: value3)), \(value4));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: Double, value3: Double, value4: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(value2), \(value3), \(JsObject.wrapQuotes(value: value4)));")

        return self
    }
    /**
     * Setter for labels padding settings in pixels using several value.
     */
    public func padding(value1: Double, value2: Double, value3: Double, value4: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).padding(\(value1), \(value2), \(value3), \(value4));")

        return self
    }
    /**
     * Getter for the labels position settings.
     */
    public func position()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".position();")
    }
    /**
     * Setter for the labels position settings.<br>
The default value and the list of available values can be different depending on where the labels are used, e.g. with axes of different types or with different charts.
Find more information in the detailed description.
     */
    public func position(position: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).position(\(JsObject.wrapQuotes(value: position)));")

        return self
    }
    /**
     * Getter for the labels position formatter function.
     */
    public func positionFormatter()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".positionFormatter();")
    }
    /**
     * Setter for the labels position formatter function.
     */
    public func positionFormatter(formatter: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).positionFormatter(\(JsObject.wrapQuotes(value: formatter)));")

        return self
    }
    /**
     * Getter for the rotation angle around an anchor.
     */
    public func rotation()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".rotation();")
    }
    /**
     * Setter for the rotation angle around an anchor.
     */
    public func rotation(angle: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).rotation(\(angle));")

        return self
    }
    /**
     * Getter for labels width settings.
     */
    public func width()  {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: self.jsBase + ".width();")
    }
    /**
     * Setter for labels width settings.
     */
    public func width(width: Double) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).width(\(width));")

        return self
    }
    /**
     * Setter for labels width settings.
     */
    public func width(width: String) -> anychart.core.ui.LabelsFactory {
        APIlib.sharedInstance.jsDelegate?.jsAddLine(jsLine: "\(self.jsBase).width(\(JsObject.wrapQuotes(value: width)));")

        return self
    }

    }
}