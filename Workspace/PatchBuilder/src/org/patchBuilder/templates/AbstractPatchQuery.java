package org.patchBuilder.templates;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.patchBuilder.QueryBuilder;
import org.patchBuilder.utils.CONST;

public abstract class AbstractPatchQuery implements QueryBuilder {

    protected static StringBuilder query = new StringBuilder();
    protected static StringBuilder temp = new StringBuilder();

    public AbstractPatchQuery() {
    }

    public AbstractPatchQuery(StringBuilder query) {
        AbstractPatchQuery.query = query;
    }

    @Override
    public abstract AbstractPatchQuery build(Map<String, List<String>> map);
    
    @Override
    public AbstractPatchQuery headerComment(String ticketCode, String Summary, String clientName, String Environments, int updatedRowCount, int runningTime) {
        query.append("-- Ticket: ").append(ticketCode).append(CONST.EOL);
        query.append("-- Summary: ").append(Summary).append(CONST.EOL);
        query.append("-- Client: ").append(clientName).append(CONST.EOL);
        query.append("-- Environments: ").append(Environments).append(CONST.EOL);
        query.append("-- Rows to be updated: ").append(updatedRowCount).append(CONST.EOL);
        query.append("-- Running time: ~ ").append(runningTime).append(" sec").append(CONST.EOL).append(CONST.EOL);
        return this;
    }

    @Override
    public AbstractPatchQuery now() {
        query.append("SET @currenttime := NOW();").append(CONST.EOL);
        return this;
    }

    @Override
    public AbstractPatchQuery getClientIDForName(String name) {
        query.append("SELECT @cid := ID FROM Client WHERE Name = '").append(name).append("';").append(CONST.EOL).append(CONST.EOL);
        return this;
    }

    @Override
    public AbstractPatchQuery addNewVar(String varName, String varValue) {
        query.append("SET @").append(varName.toUpperCase()).append(" := ").append(varValue).append(CONST.EOL).append(CONST.EOL);
        return this;
    }

    @Override
    public AbstractPatchQuery clear() {
        query.delete(0, query.length());
        return this;
    }

    // protected StringBuilder insert(String value) {
    // temp.delete(0, temp.length());
    // if (value == null || value.equals(CONST.NULL)) {
    // temp.append(CONST.NULL).append(",").append(CONST.EOL);
    // } else {
    // temp.append(CONST.QUO).append(value).append(CONST.QUO).append(",").append(CONST.EOL);
    // }
    // return temp;
    // }

    @Override
    public File write2File(File output) {

        try (FileWriter fw = new FileWriter(output)) {
            fw.write(this.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return output;
    }

    @Override
    public String toString() {
        return query.toString();
    }
}
