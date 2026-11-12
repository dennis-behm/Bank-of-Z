/*******************************************************************************
 * Licensed Materials - Property of IBM
 * (c) Copyright IBM Corporation 2026. All Rights Reserved.
 *
 * Note to U.S. Government Users Restricted Rights:
 * Use, duplication or disclosure restricted by GSA ADP Schedule
 * Contract with IBM Corp.
 *******************************************************************************/
package com.ibm.edt.dependency

import org.slf4j.Logger
import org.slf4j.LoggerFactory

import java.io.InputStream
import java.io.InputStreamReader
import java.io.BufferedReader

import com.ibm.dbb.dependency.AbstractDependencyScanner
import com.ibm.dbb.dependency.LogicalDependency
import com.ibm.dbb.dependency.LogicalFile

/**
 * zBuilder dependency scanner for EDT V3 COBOL unit test case source files (*.test.cbl).
 *
 * <p>Scans a generated EDT unit test case file and extracts the load module name of
 * the Program Under Test from the first {@code LOAD-MODULE-NAME} working-storage
 * declaration, emitting it as a {@code SYSPROG} logical dependency so that
 * zBuilder impact analysis can trace changes to the application program through
 * to the test cases that exercise it.
 *
 * <p>Register this scanner in zBuilder for the {@code test.cbl} file extension:
 * <pre>
 *   DependencyScannerRegistry.addScanner("test.cbl", new EDTCobolUnitTestCaseScanner())
 * </pre>
 */
class EDTCobolUnitTestCaseScanner extends AbstractDependencyScanner {

    protected static Logger logger = LoggerFactory.getLogger(EDTCobolUnitTestCaseScanner.class)

    String DEFAULT_DEPENDENCY_REFERENCE_TYPE = "EDTINC"; //$NON-NLS-1$

    // Matches: 01  LOAD-MODULE-NAME    PIC  X(08) VALUE 'PROGNAME'.
    // Group 1 captures the quoted program name.
    private static final java.util.regex.Pattern LOAD_MODULE_DECL =
            ~/(?i)^\s+01\s+LOAD-MODULE-NAME\s+PIC\s+X\s*\(\s*0*8\s*\)\s+VALUE\s+['"]([^'"]+)['"]/

    @Override
    protected Object runScan(String file, InputStream inputStream, String encoding) {
        logger.debug("Scanning EDT unit test case file = {}, encoding = {}", file, encoding)

        LogicalFile lfile = new LogicalFile(createLogicalName(file), file, "EDTTEST", false, false, false)

        new BufferedReader(new InputStreamReader(inputStream, encoding)).withCloseable { reader ->
            for (String line : reader.readLines()) {
                def m = LOAD_MODULE_DECL.matcher(line)
                if (m.find()) {
                    String loadModuleName = m.group(1).trim().toUpperCase()
                    logger.debug("Found LOAD-MODULE-NAME: '{}'", loadModuleName)
                    lfile.addLogicalDependency(new LogicalDependency(loadModuleName, "SYSPROG", DEFAULT_DEPENDENCY_REFERENCE_TYPE))
                    break
                }
            }
        }

        if (lfile.getLogicalDependencies().isEmpty()) {
            logger.warn("No LOAD-MODULE-NAME declaration found in EDT unit test case file: {}", file)
        }

        logger.debug("Produced logical file: {}", lfile)
        return lfile
    }

    @Override
    protected LogicalFile createLogicalFile(String file, Object scanMetadata) {
        LogicalFile lfile = (LogicalFile) scanMetadata
        logger.debug("Created logical file from EDT unit test case scan metadata {}", lfile)
        return lfile
    }
}
