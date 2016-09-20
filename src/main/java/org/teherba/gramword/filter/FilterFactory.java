/*  Selects the applicable filter
 *  @(#) $Id: FilterFactory.java 564 2010-10-19 16:29:18Z gfis $
 *  2016-09-19: old package was gramword.filters; dynamic class testing
 *  2010-10-19: transformer.initialize()
 *  2007-04-18: NumberFilter, KontoFilter
 *  2007-02-27: copied from TransformerFactory
*/
/*
 * Copyright 2006 Dr. Georg Fischer <punctum at punctum dot kom>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.teherba.gramword.filter;
import  org.teherba.gramword.filter.BaseFilter;
import  org.teherba.xtrans.BaseTransformer;
import  org.teherba.xtrans.XMLTransformer;
import  java.util.ArrayList;
import  java.util.Iterator;
import  java.util.StringTokenizer;
import  org.apache.log4j.Logger;

/** Selects a specific filter and iterates over the descriptions
 *  of all filters and their codes.
 *  A filter is a subclass of {@link BaseFilter} which in turn 
 *  is based on {@link BaseTransformer}. 
 *  The output of a filter is serialized by @link XMLTransformer}.
 *  @author Dr. Georg Fischer
 */
public class FilterFactory {
    public final static String CVSID = "@(#) $Id: FilterFactory.java 564 2010-10-19 16:29:18Z gfis $";

    /** log4j logger (category) */
    private Logger log;

    /** Empty Constructor
     */
    public FilterFactory() {
        log = Logger.getLogger(FilterFactory.class.getName());
        // the order here defines the order in the web page
        try {
            transformers = new ArrayList<BaseTransformer>(16);
            transformers.add(new XMLTransformer());
            // the order here defines the order in documentation.jsp,
            // should be: "... group by package order by package, name"
            this.addClass("BaseFilter");
            this.addClass("BibleRefFilter");
            this.addClass("KontoFilter");
            this.addClass("NumberFilter");
            this.addClass("WordTypeFilter");
        } catch (Exception exc) {
            log.error(exc.getMessage(), exc);
        }
    } // Constructor

    /** ArrayList of transformers for different formats */
    protected ArrayList<BaseTransformer> transformers;

    /** Attempts to instantiate the class for some transformer = format
     *  @param transformerName name of the class for the transformer,
     *  without the prefix "org.teherba.xtrans.".
     */
    private void addClass(String transformerName) {
        try {
            BaseTransformer transformer = (BaseTransformer)
                    Class.forName("org.teherba.gramword.filter." + transformerName)
                    .newInstance();
            if (transformer != null) {
                // transformer.initialize();
                transformers.add(transformer);
            } // != null
        } catch (Exception exc) {
            // log.info(exc.getMessage(), exc);
            // ignore any error silently - this format will not be known
        }
    } // addClass

    /** Determines whether the format code denotes this
     *  transformer class.
     *  @param transformer the transformer to be tested
     *  @param format code for the desired format
     */
    private boolean isApplicable(BaseTransformer transformer, String format) {
        boolean result = false;
        // log.debug("tokenizer:" + transformer.getFormatCodes());
        StringTokenizer tokenizer = new StringTokenizer(transformer.getFormatCodes(), ",");
        while (! result && tokenizer.hasMoreTokens()) { // try all tokens
            if (format.equals(tokenizer.nextToken())) {
                result = true;
            }
        } // while all tokens
        return result;
    } // isApplicable

    /** Gets the applicable transformer for a specified format code.
     *  @param format abbreviation for the format according to ISO 639
     *  @return the transformer for that format, or <em>null</em> if the
     *  format was not found
     */
    public BaseTransformer getTransformer(String format) {
        BaseTransformer transformer = null;
        Iterator<BaseTransformer> titer = getIterator();
        boolean busy = true;
        while (busy && titer.hasNext()) {
            transformer = titer.next();
            if (isApplicable(transformer, format)) { // found this format
                transformer.initialize();
                busy = false; // break loop
                // log.info("getTransformer(\"" + format + "\") = " + transformer);
                // found this format
            } else {
                transformer = null;
            }
        } // while busy
        return transformer;
    } // getTransformer

    /** Gets an Iterator over all implemented transformers.
     *  @return list iterator over {@link #transformers}
     */
    public Iterator<BaseTransformer> getIterator() {
        return transformers.iterator();
    } // getIterator

    /** Gets the number of available transformers
     *  @return number of formats which can be spelled
     */
    public int size() {
        return transformers.size();
    } // size

    /** Returns a list of available transformers
     */
    public String toString() {
        StringBuffer result = new StringBuffer(1024);
        Iterator<BaseTransformer> iter = this.getIterator();
        while (iter.hasNext()) {
            BaseTransformer trans = iter.next();
            String name = trans.getClass().getName();
            result.append(name);
            result.append(' ');
            result.append(trans.getFormatCodes());
            result.append("\n");
        } // while hasNext
        return result.toString();
    } // toString

    /** Main program, writes the list of available filters
     *  @param args commandline arguments (none)
     */
    public static void main(String args[]) {
        FilterFactory factory = new FilterFactory();
        System.out.print(factory.toString());
    } // main

} // FilterFactory
