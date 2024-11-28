import React, { useState } from 'react';
import axios from 'axios';

const JPAtoSQLConverter = () => {
    const [jpaQuery, setJpaQuery] = useState('');
    const [sqlQuery, setSqlQuery] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
          const response = await axios.post('localhost:8080/convertQuery', { jpaQuery });
            setSqlQuery(response.data.sqlQuery); 
            alert(response.data.sqlQuery); // Display the SQL query
        } catch (error) {
            console.error('Error converting JPA query:', error);
            alert('Error converting query');
        }
    };

    return (
        <div>
            <h1>Convert JPA Query to SQL</h1>
            <form onSubmit={handleSubmit}>
                <textarea
                    value={jpaQuery}
                    onChange={(e) => setJpaQuery(e.target.value)}
                    placeholder="Enter JPA query"
                />
                <button type="submit">Convert</button>
            </form>
            {sqlQuery && <pre>{sqlQuery}</pre>}
        </div>
    );
};

export default JPAtoSQLConverter;
